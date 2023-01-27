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


