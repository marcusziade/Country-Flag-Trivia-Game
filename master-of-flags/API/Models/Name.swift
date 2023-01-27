import Foundation

struct Name: Codable, Hashable, Comparable {
    static func < (lhs: Name, rhs: Name) -> Bool {
        lhs.common == rhs.common
    }

    let official: String
    let common: String
}


