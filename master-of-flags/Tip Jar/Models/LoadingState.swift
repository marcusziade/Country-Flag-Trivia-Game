import Foundation
import UIKit

enum LoadingState: String {
    case loading, purchasing, failed, purchased, error

    var title: String {
        switch self {
        case .loading:
            return NSLocalizedString("Loading", comment: "Loading title label")
        case .purchasing:
            return NSLocalizedString("Purchasing", comment: "Purchasing title label")
        case .failed:
            return NSLocalizedString("Failed", comment: "Failed title label")
        case .purchased:
            return NSLocalizedString("Purchased", comment: "Purchased title label")
        case .error:
            return NSLocalizedString("Error loading products", comment: "Purchased title label")
        }
    }

    var color: UIColor {
        switch self {
        case .loading:
            return .systemFill
        case .purchasing:
            return .systemBlue
        case .failed:
            return .systemRed
        case .purchased:
            return .systemGreen
        case .error:
            return .systemRed
        }
    }
}
