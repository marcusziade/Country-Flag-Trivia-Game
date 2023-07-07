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
        case (.error, .error):
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
    case error

    var title: String {
        switch self {
        case .purchasing:
            return NSLocalizedString("Purchasing", comment: "Purchasing title label")
        case .purchased(_):
            return NSLocalizedString("Purchased", comment: "Purchased title label")
        case .failed:
            return NSLocalizedString("Failed", comment: "Failed title label")
        case .restored:
            return NSLocalizedString("Restored", comment: "Restored title label")
        case .deferred:
            return NSLocalizedString("Deferred", comment: "Deferred title label")
        case .error:
            return NSLocalizedString("Error", comment: "Error title label")
        }
    }
}
