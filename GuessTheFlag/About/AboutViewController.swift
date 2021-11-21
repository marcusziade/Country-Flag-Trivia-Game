//
//  AboutViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Lottie
import StoreKit
import UIKit

final class AboutViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(gradientLayer)
        SKPaymentQueue.default().add(self)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, infoLabel]).forAutoLayout()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 48

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        view.addSubview(button)

        button.addSubview(loader)
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 3),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 10),

            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 3),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 2),

            button.heightAnchor.constraint(equalToConstant: 55),
            button.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            loader.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: button.centerXAnchor),

            animationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        fetchProducts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !Authentication.parentalGateUnlocked {
            view.alpha = 0
            var parentalGate = ParentalGateView()
            
            parentalGate.onCancel = { [weak self] in
                guard let self = self else { return }
                HapticEngine.result.notificationOccurred(.error)
                self.dismiss(animated: true)
                if let tabBarController = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
                    tabBarController.selectedIndex = 1
                }
            }
            
            parentalGate.onClose = { [weak self] in
                guard let self = self else { return }
                Authentication.parentalGateUnlocked = true
                self.dismiss(animated: true)
                HapticEngine.result.notificationOccurred(.success)
                UIView.animate(withDuration: 0.25) {
                    self.view.alpha = 1
                }
            }
            
            let viewController = UIHostingController(rootView: parentalGate)
            viewController.isModalInPresentation = true
            present(viewController, animated: true)
        }
    }

    // MARK: - Private
    
    private enum Product: String, CaseIterable {
        case buyCoffee = "com.marcusziade.knowtheflag.buycoffee"
    }
        
    private var products: [SKProduct] = []
        
    private let scrollView = UIScrollView().configure {
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let contentView = UIView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var button = UIButton().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        $0.setTitle("☕️ Buy me coffee", for: .normal)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .brown
        $0.setTitleColor(.white, for: .normal)
        $0.addShadow(color: .black, offset: CGSize(width: 3.0, height: 3.0), opacity: 0.4, radius: 4.0)
    }
    
    private let loader = UIActivityIndicatorView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.hidesWhenStopped = true
        $0.color = .white
    }
    
    private lazy var gradientLayer = CAGradientLayer().configure {
        $0.frame = view.bounds
        $0.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        $0.startPoint = CGPoint.zero
        $0.endPoint = CGPoint(x: 0.5, y: 1.5)
    }
    
    private let titleLabel = UILabel().configure {
        $0.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: .init(legibilityWeight: .bold))
        $0.text = "Master of Flags"
        $0.textColor = .white
    }
    
    private let infoLabel = UILabel().configure {
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.text =
            """
            This is Master of Flags, the game where you gather experience points (XP) and level up as you become familiar with the world's flags. There are 196 different flags in this game! Your objective is to learn them all🤓
            
            You gain 15 XP from a correct answer and lose 10 XP from a wrong answer. The correct answer is indicated by the spinning flag!🌀
            You need 450 points to level up☄️
            
            Browse the encyclopedia to improve your geographical knowledge📚
            """
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private lazy var animationView = AnimationView(name: "coffee").configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
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
            loader.startAnimating()
            button.setTitle("", for: .normal)
        } else {
            loader.stopAnimating()
            button.setTitle("☕️ \(products[0].localizedTitle) \(products[0].priceLocale.currencySymbol ?? "")\(products[0].price)", for: .normal)
        }
    }

    private func showCoffeeAnimation() {
        UIView.animate(withDuration: 0.2) { [self] in
            animationView.alpha = 1
        }

        animationView.play { [weak self] _ in
            UIView.animate(withDuration: 0.2) { [self] in
                self?.animationView.alpha = 0
            }
        }
    }
    
    @objc private func buttonPressed() {
        let payment = SKPayment(product: products[0])
        SKPaymentQueue.default().add(payment)
    }
}

extension AboutViewController: SKProductsRequestDelegate {
    
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

extension AboutViewController: SKPaymentTransactionObserver {
    
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

struct AboutViewController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: UINavigationController(rootViewController: AboutViewController()), mode: .dark)
}
