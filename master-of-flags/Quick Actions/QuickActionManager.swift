import Foundation
import UIKit

final class QuickActionManager {

    enum ShortcutIdentifier: String, CaseIterable {
        case game, encyclopedia

        var localizedTitle: String {
            switch self {
            case .game:
                return NSLocalizedString("Game", comment: "")
            case .encyclopedia:
                return NSLocalizedString("Encyclopedia", comment: "")
            }
        }

        var icon: UIApplicationShortcutIcon {
            switch self {
            case .game:
                return UIApplicationShortcutIcon(systemImageName: "gamecontroller")
            case .encyclopedia:
                return UIApplicationShortcutIcon(systemImageName: "doc.text.magnifyingglass")
            }
        }

        var shortcut: UIApplicationShortcutItem {
            UIApplicationShortcutItem(
                type: rawValue,
                localizedTitle: localizedTitle,
                localizedSubtitle: nil,
                icon: icon
            )
        }
    }

    func create() {
        let shortcuts = ShortcutIdentifier.allCases.map(\.shortcut)
        application.shortcutItems = shortcuts
    }

    func disable() {
        application.shortcutItems = []
    }

    func handleShortcutItem(
        _ item: UIApplicationShortcutItem?,
        window: UIWindow?,
        completionHandler: ((Bool) -> Void)
    ) {
        guard let tabBarController = window?.rootViewController as? MainTabBarController else {
            assertionFailure("Failed to find tab bar controller")
            completionHandler(false)
            return
        }

        guard let shortcut = QuickActionManager.ShortcutIdentifier(rawValue: item?.type ?? "") else {
            assertionFailure("Unknown app shortcut identifier \(item?.type ?? "")")
            completionHandler(false)
            return
        }

        tabBarController.handleShortcut(shortcut)

        completionHandler(true)
    }

    // MARK: - Private

    private let application = UIApplication.shared
}


