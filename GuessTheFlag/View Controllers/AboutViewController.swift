//
//  AboutViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit
import StoreKit
import Lottie

class AboutViewController: UIViewController {

    // MARK: - Types
    enum Product: String, CaseIterable {
        case buyCoffee = "com.marcusziade.knowtheflag.buycoffee"
    }

    // MARK: - Properties
    var products: [SKProduct] = []
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - UI Components
    let scrollView: UIScrollView = {
        let view = UIScrollView().forAutoLayout()
        view.showsVerticalScrollIndicator = false
        return view
    }()

    let contentView: UIView = {
        let view = UIView().forAutoLayout()
        return view
    }()

    lazy var button: UIButton = {
        let button = UIButton(type: .system).forAutoLayout()
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.setTitle("☕️ Buy me coffee", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
        button.addShadow(color: .black, offset: CGSize(width: 3.0, height: 3.0), opacity: 0.4, radius: 4.0)
        return button
    }()

    lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView().forAutoLayout()
        view.hidesWhenStopped = true
        view.color = .black
        return view
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0.5, y: 1.5)
        return gradient
    }()

    let titleLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: .init(legibilityWeight: .bold))
        label.text = "Master of Flags"
        label.textColor = .white
        return label
    }()

    let infoLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text =
            """
            This is Master of Flags, the game where you gather experience points (XP) and level up as you become familiar with the world's flags. There are 196 different flags in this game! Your objective is to learn them all🤓

            You gain 15 XP from a correct answer and lose 10 XP from a wrong answer. The correct answer is indicated by the spinning flag!🌀
            You need 450 points to level up☄️

            Browse the encyclopedia to improve your geographical knowledge📚
            """
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var animationView: AnimationView = {
        let view = AnimationView(name: "coffee").forAutoLayout()
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.backgroundColor = .clear
        view.alpha = 0
        return view
    }()

    // MARK: - Lifecycle methods
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
            HapticEngine.result.notificationOccurred(.success)
            scrollView.flashScrollIndicators()
        }
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

    // MARK: - Methods
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.map(\.rawValue)))
        request.delegate = self
        request.start()
    }

    func isLoading(_ bool: Bool) {
        if bool {
            loader.startAnimating()
            button.setTitle("", for: .normal)
        } else {
            loader.stopAnimating()
            button.setTitle("☕️ \(products[0].localizedTitle) \(products[0].priceLocale.currencySymbol ?? "")\(products[0].price)", for: .normal)
        }
    }

    func showCoffeeAnimation() {
        UIView.animate(withDuration: 0.2) { [self] in
            animationView.alpha = 1
        }

        animationView.play { [weak self] _ in
            UIView.animate(withDuration: 0.2) { [self] in
                self?.animationView.alpha = 0
            }
        }
    }

    // MARK: - Selectors
    @objc func buttonPressed() {
        let payment = SKPayment(product: products[0])
        SKPaymentQueue.default().add(payment)
    }
}

extension AboutViewController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async { [self] in
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
                    print("Purchasing")
                    isLoading(true)
                case .purchased:
                    print("Purchased")
                    isLoading(false)
                    let transaction: SKPaymentTransaction = $0
                    SKPaymentQueue.default().finishTransaction(transaction)
                    showCoffeeAnimation()
                case .failed:
                    print("Purchase failed")
                    isLoading(false)
                case .restored:
                    print("Purchase restored")
                    isLoading(false)
                case .deferred:
                    print("Purhcase deferred")
                    isLoading(false)
                @unknown default: break
            }
        }
    }
}

import SwiftUI

struct AboutViewController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: AboutViewController(), mode: .dark)
}

