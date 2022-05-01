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
    var price: String { get }
    var color: UIColor { get }
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
    
    var title: String {
        skProduct.localizedTitle
    }
    
    var description: String {
        skProduct.localizedDescription
    }
    
    var price: String {
        let symbol = skProduct.priceLocale.currencySymbol ?? ""
        let price = skProduct.price
        return "\(price)\(symbol)"
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
    
    var color: UIColor {
        switch productType {
        case .coffee:
            return .systemBrown
        case .smallTip:
            return .systemGray
        case .avocado:
            return .systemGreen
        case .lunch:
            return .systemTeal
        }
    }
    
    // MARK: - Private
    
    private let productType: ProductType
}

// MARK: - Mock

struct MockTipJarProduct: TipJarProductProtocol {
    let title = "Avocado"
    let animation = "avocado"
    let price = "12.99€"
    let color = UIColor.systemGreen
}
