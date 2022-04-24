//
//  TipJarViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Combine
import Foundation
import Lottie
import SnapKit
import SwiftUI
import UIKit

final class TipJarViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.addSublayer(gradientLayer)
        
        view.addAndConstrainSubview(button) {
            $0.center.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(250)
        }
        
        button.addAndConstrainSubview(loaderView) {
            $0.center.equalToSuperview()
        }
        
        view.addAndConstrainSubview(animationView) {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        model.fetchProducts()
        startListeningForStoreKit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        openParentalGateIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        gradientLayer.frame = view.bounds
    }
    
    // MARK: - Private
    
    private let model = TipJarViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isLoading: Bool = true {
        didSet {
            if isLoading {
                loaderView.startAnimating()
                button.setTitle("", for: .normal)
            } else {
                loaderView.stopAnimating()
                button.setTitle("☕️ \(model.products[0].localizedTitle) \(model.products[0].priceLocale.currencySymbol ?? "")\(model.products[0].price)", for: .normal)
            }
        }
    }
    
    private lazy var gradientLayer = CAGradientLayer().configure {
        $0.frame = view.bounds
        $0.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        $0.startPoint = CGPoint.zero
        $0.endPoint = CGPoint(x: 0.5, y: 1.5)
    }
    
    private lazy var button = UIButton().configure {
        $0.setTitle("☕️ Buy me coffee", for: .normal)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .brown
        $0.setTitleColor(.white, for: .normal)
        $0.addShadow(color: .black, offset: CGSize(width: 3.0, height: 3.0), opacity: 0.4, radius: 4.0)
        
        $0.addAction(UIAction { [unowned self] _ in model.buttonPressed() }, for: .touchUpInside)
    }
    
    private let loaderView = UIActivityIndicatorView().configure {
        $0.hidesWhenStopped = true
        $0.color = .white
    }
    
    private let animationView = AnimationView(name: "coffee").configure {
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .playOnce
        $0.backgroundColor = .clear
        $0.alpha = 0
    }
    
    private func showCoffeeAnimation() {
        UIView.animate(withDuration: 0.2) { [self] in
            animationView.alpha = 1
        }
        
        animationView.play { [weak self] _ in
            UIView.animate(withDuration: 0.2) {
                self?.animationView.alpha = 0
            }
        }
    }
    
    private func startListeningForStoreKit() {
        model.onTransactionStateChanged.sink { [unowned self] state in
            switch state {
            case .purchasing:
                print("Purchasing")
            case .purchased:
                showCoffeeAnimation()
            case .failed:
                print("failed")
            case .restored:
                print("restored")
            case .deferred:
                print("deferred")
            }
            
            isLoading = state == .purchasing
        }
        .store(in: &cancellables)
        
        model.onProductsLoaded.sink { [unowned self] in
            DispatchQueue.main.async { [self] in
                isLoading = false
            }
        }
        .store(in: &cancellables)
    }
    
    private func openParentalGateIfNeeded() {
        if !Settings.parentalGateUnlocked {
            var parentalGate = ParentalGateView()
            
            parentalGate.onCancel = { [weak self] in
                guard let self = self else { return }
                HapticEngine.result.notificationOccurred(.error)
                self.dismiss(animated: true)
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            parentalGate.onClose = { [weak self] in
                guard let self = self else { return }
                Settings.parentalGateUnlocked = true
                self.dismiss(animated: true)
                HapticEngine.result.notificationOccurred(.success)
            }
            
            let viewController = UIHostingController(rootView: parentalGate)
            viewController.isModalInPresentation = true
            present(viewController, animated: true)
        }
    }
}

import SwiftUI

struct TipJarViewController_Preview: PreviewProvider {
    
    static var previews: some View = createPreview(
        for: UINavigationController(rootViewController: TipJarViewController()),
        mode: .dark
    )
}
