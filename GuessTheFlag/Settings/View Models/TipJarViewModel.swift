//
//  TipJarViewModel.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Combine
import Foundation
import StoreKit

enum Product: String, CaseIterable {
    case buyCoffee = "com.marcusziade.knowtheflag.buycoffee"
    case smallTip = "com.marcusziade.knowtheflag.smalltip"
    case avocado = "com.marcusziade.knowtheflag.avocado"
    case lunch = "com.marcusziade.knowtheflag.lunch"
}

enum TransationState {
    case purchasing, purchased, failed, restored, deferred
}

final class TipJarViewModel: NSObject {
    
    var onTransactionStateChanged = PassthroughSubject<TransationState, Never>()
    var onProductsLoaded = PassthroughSubject<Void, Never>()
    
    var products: [SKProduct] = []
    
    override init() {
        super.init()
        
        SKPaymentQueue.default().add(self)
    }
    
    func buttonPressed() {
        let payment = SKPayment(product: products[0])
        SKPaymentQueue.default().add(payment)
    }
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.map(\.rawValue)))
        request.delegate = self
        request.start()
    }
}

// MARK: - SKProductsRequestDelegate

extension TipJarViewModel: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        onProductsLoaded.send()
        
        print("Valid products: ", products)
        print("Invalid products: ", response.invalidProductIdentifiers)
    }
}

// MARK: - SKPaymentTransactionObserver

extension TipJarViewModel: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchasing:
                onTransactionStateChanged.send(.purchasing)
                
            case .purchased:
                onTransactionStateChanged.send(.purchased)
                let transaction: SKPaymentTransaction = $0
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .failed:
                onTransactionStateChanged.send(.failed)
                
            case .restored:
                onTransactionStateChanged.send(.restored)
                
            case .deferred:
                onTransactionStateChanged.send(.deferred)
                
            @unknown default: break
            }
        }
    }
}
