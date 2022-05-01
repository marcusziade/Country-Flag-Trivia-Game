//
//  TipJarProduct.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import StoreKit

protocol TipJarProductProtocol {
    
    var title: String { get }
    var animation: String { get }
}

struct TipJarProduct: TipJarProductProtocol {
    
    enum ProductType: String, CaseIterable {
        case coffee = "com.marcusziade.knowtheflag.buycoffee"
        case smallTip = "com.marcusziade.knowtheflag.smalltip"
        case avocado = "com.marcusziade.knowtheflag.avocado"
        case lunch = "com.marcusziade.knowtheflag.lunch"
    }
    
    let skProduct: SKProduct
    
    init(product: SKProduct) {
        self.skProduct = product
        self.productType = ProductType(rawValue: skProduct.productIdentifier)!
    }
    
    var id: String {
        switch productType {
        case .coffee:
            return "com.marcusziade.knowtheflag.buycoffee"
        case .smallTip:
            return "com.marcusziade.knowtheflag.smalltip"
        case .avocado:
            return "com.marcusziade.knowtheflag.avocado"
        case .lunch:
            return "com.marcusziade.knowtheflag.lunch"
        }
    }
    
    var title: String {
        switch productType {
        case .coffee:
            return NSLocalizedString("Caffè latte", comment: "latte title label")
        case .smallTip:
            return NSLocalizedString("Small tip", comment: "Small tip title label")
        case .avocado:
            return NSLocalizedString("Avocado", comment: "Avocade title label")
        case .lunch:
            return NSLocalizedString("Lunch", comment: "Lunch title label")
        }
    }
    
    var animation: String {
        switch productType {
        case .coffee:
            return "coffee"
        case .smallTip:
            return "tip"
        case .avocado:
            return "avocado"
        case .lunch:
            return "lunch"
        }
    }
    
    // MARK: - Private
    
    private let productType: ProductType
}

// MARK: - Mock

struct MockTipJarProduct: TipJarProductProtocol {
    let title = "Avocado"
    let animation = "Avocado"
}
