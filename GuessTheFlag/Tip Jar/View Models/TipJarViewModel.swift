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

final class TipJarViewModel: NSObject {
    
    var onTransactionStateChanged = PassthroughSubject<TipJarTransactionState, Never>()
    var onProductsLoaded = PassthroughSubject<Void, Never>()
    
    var products = CurrentValueSubject<[TipJarProduct], Never>([])
    var selectedProduct: TipJarProduct? = nil
    
    override init() {
        super.init()
        
        SKPaymentQueue.default().add(self)
        fetchProducts()
    }
    
    func productSelected(for indexPath: IndexPath) {
        selectedProduct = products.value[indexPath.item]
        guard let validProduct = selectedProduct else { return }
        let payment = SKPayment(product: validProduct.skProduct)
        SKPaymentQueue.default().add(payment)
    }
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(TipJarProduct.ProductType.allCases.map { $0.rawValue }) )
        request.delegate = self
        request.start()
    }
}

// MARK: - SKProductsRequestDelegate

extension TipJarViewModel: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products.send(response.products.map { TipJarProduct(product: $0) })
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
                onTransactionStateChanged.send(.purchased(product: selectedProduct!))
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
