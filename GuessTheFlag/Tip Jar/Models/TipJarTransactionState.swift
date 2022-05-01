//
//  TipJarTransactionState.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 1.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation

enum TipJarTransactionState: Equatable {
    static func == (lhs: TipJarTransactionState, rhs: TipJarTransactionState) -> Bool {
        switch (lhs, rhs) {
        case (.purchasing, .purchasing):
            return true
        case (.purchased(product: _), .purchased(product: _)):
            return true
        case (.failed, .failed):
            return true
        case (.restored, .restored):
            return true
        case (.deferred, .deferred):
            return true
        default:
            return false
        }
    }
    
    case purchasing
    case purchased(product: TipJarProduct)
    case failed
    case restored
    case deferred
}
