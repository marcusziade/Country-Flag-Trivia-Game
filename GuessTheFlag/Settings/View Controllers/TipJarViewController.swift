//
//  TipJarViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import Lottie
import SnapKit
import StoreKit
import SwiftUI
import UIKit

final class TipJarViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKPaymentQueue.default().add(self)
        
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
        
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        gradientLayer.frame = view.bounds
    }
    
    // MARK: - Private
    
    private enum Product: String, CaseIterable {
        case buyCoffee = "com.marcusziade.knowtheflag.buycoffee"
    }
    
    private var products: [SKProduct] = []
    
    private lazy var gradientLayer = CAGradientLayer().configure {
        $0.frame = view.bounds
        $0.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        $0.startPoint = CGPoint.zero
        $0.endPoint = CGPoint(x: 0.5, y: 1.5)
    }
    
    private lazy var button = UIButton().configure {
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.setTitle("☕️ Buy me coffee", for: .normal)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .brown
        $0.setTitleColor(.white, for: .normal)
        $0.addShadow(color: .black, offset: CGSize(width: 3.0, height: 3.0), opacity: 0.4, radius: 4.0)
    }
    
    private let loaderView = UIActivityIndicatorView().configure {
        $0.hidesWhenStopped = true
        $0.color = .white
    }
    
    private lazy var animationView = AnimationView(name: "coffee").configure {
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .playOnce
        $0.backgroundColor = .clear
        $0.alpha = 0
    }
    
    private func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.map(\.rawValue)))
        request.delegate = self
        request.start()
    }
    
    private func isLoading(_ bool: Bool) {
        if bool {
            loaderView.startAnimating()
            button.setTitle("", for: .normal)
        } else {
            loaderView.stopAnimating()
            button.setTitle("☕️ \(products[0].localizedTitle) \(products[0].priceLocale.currencySymbol ?? "")\(products[0].price)", for: .normal)
        }
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
    
    @objc private func buttonPressed() {
        let payment = SKPayment(product: products[0])
        SKPaymentQueue.default().add(payment)
    }
}

// MARK: - SKProductsRequestDelegate

extension TipJarViewController: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async { [unowned self] in
            products = response.products
            button.setTitle("☕️ \(products[0].localizedTitle) \(products[0].priceLocale.currencySymbol ?? "")\(products[0].price)", for: .normal)
            button.isHidden = false
            print(products)
            print(response.invalidProductIdentifiers)
        }
    }
}

// MARK: - SKPaymentTransactionObserver

extension TipJarViewController: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchasing:
                isLoading(true)
            case .purchased:
                isLoading(false)
                let transaction: SKPaymentTransaction = $0
                SKPaymentQueue.default().finishTransaction(transaction)
                showCoffeeAnimation()
            case .failed:
                isLoading(false)
            case .restored:
                isLoading(false)
            case .deferred:
                isLoading(false)
            @unknown default: break
            }
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
