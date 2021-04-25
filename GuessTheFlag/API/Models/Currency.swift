//
//  Currency.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Foundation

struct Currency: Codable, Hashable {

    // MARK: - Properties
    
    let code: String?
    let name: String?
    let symbol: String?

    static func generateMockCurrencies() -> [Currency] {
        return (0...3).map { index -> Currency in
            return Currency(
                code: "EUR",
                name: "Euro",
                symbol: "€"
            )
        }
    }
}
