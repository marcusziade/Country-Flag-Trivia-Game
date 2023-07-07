import Foundation

enum SettingsSection: Int, CaseIterable {
    case general, game, support

    var headerTitle: String {
        switch self {
        case .general:
            return NSLocalizedString("General", comment: "General header title")
        case .game:
            return NSLocalizedString("Game", comment: "Game header title")
        case .support:
            return NSLocalizedString("Support", comment: "Support header title")
        }
    }
}
