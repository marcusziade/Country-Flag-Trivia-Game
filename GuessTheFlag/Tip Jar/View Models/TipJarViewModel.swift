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

enum TransationState {
    case purchasing, purchased, failed, restored, deferred
}

final class TipJarViewModel: NSObject {
    
    var onTransactionStateChanged = PassthroughSubject<TransationState, Never>()
    var onProductsLoaded = PassthroughSubject<Void, Never>()
    
    var products = CurrentValueSubject<[SKProduct], Never>([])
    
    override init() {
        super.init()
        
        SKPaymentQueue.default().add(self)
    }
    
    func buttonPressed() {
        let payment = SKPayment(product: products.value[0])
        SKPaymentQueue.default().add(payment)
    }
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(TipJarProduct.allCases.map(\.id)))
        request.delegate = self
        request.start()
    }
}

// MARK: - SKProductsRequestDelegate

extension TipJarViewModel: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products.send(response.products)
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
