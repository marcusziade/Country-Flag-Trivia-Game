//
//  AboutViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit
import StoreKit

class AboutViewController: UIViewController {

    // MARK: - Types
    enum Product: String, CaseIterable {
        case buyCoffee = "com.marcusziade.knowtheflag.buycoffee"
    }

    // MARK: - Properties
    var products: [SKProduct] = []

    // MARK: - UI Components
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

    lazy var aboutTextView = UIHostingController(rootView: About())
    lazy var aboutTextViewConstraints = [
        aboutTextView.view.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
        aboutTextView.view.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: aboutTextView.view.trailingAnchor, multiplier: 4),
    ]

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0.5, y: 1.5)
        return gradient
    }()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(gradientLayer)
        aboutTextView.view.backgroundColor = .clear
        SKPaymentQueue.default().add(self)

        install(aboutTextView, to: view, with: aboutTextViewConstraints)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalToSystemSpacingBelow: aboutTextView.view.bottomAnchor, multiplier: 5),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 4),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 4),
            button.heightAnchor.constraint(equalToConstant: 55),
        ])

        fetchProducts()
    }

    // MARK: - Methods
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.map(\.rawValue)))
        request.delegate = self
        request.start()
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
                case .purchased:
                    print("Purchased")
                case .failed:
                    print("Purchase failed")
                case .restored:
                    print("Purchase restored")
                case .deferred:
                    print("Purhcase deferred")
                @unknown default: break
            }
        }
    }
}

import SwiftUI

struct AboutViewController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: AboutViewController(), mode: .dark)
}

