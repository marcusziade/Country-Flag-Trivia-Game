//
//  Currency.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Foundation

struct Currency: Codable, Hashable, Comparable {
    static func < (lhs: Currency, rhs: Currency) -> Bool {
        lhs.name == rhs.name
    }

    // MARK: - Properties

    let code: String?
    let name: String
    let symbol: String?

    static var mockCurrency: Currency {
        return Currency(
            code: "EUR",
            name: "Euro",
            symbol: "€"
        )
    }
}
