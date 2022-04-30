//
//  TipJarProduct.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation

enum TipJarProduct: String, CaseIterable {
    case buyCoffee, smallTip, avocado, lunch
    
    var id: String {
        switch self {
        case .buyCoffee:
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
        switch self {
        case .buyCoffee:
            return NSLocalizedString("Caffè latte", comment: "latte title label")
        case .smallTip:
            return NSLocalizedString("Small tip", comment: "Small tip title label")
        case .avocado:
            return NSLocalizedString("1x Avocado", comment: "Avocade title label")
        case .lunch:
            return NSLocalizedString("Lunch", comment: "Lunch title label")
        }
    }
    
    var animation: String {
        switch self {
        case .buyCoffee:
            return "coffee"
        case .smallTip:
            return "tip"
        case .avocado:
            return "avocado"
        case .lunch:
            return "lunch"
        }
    }
}
