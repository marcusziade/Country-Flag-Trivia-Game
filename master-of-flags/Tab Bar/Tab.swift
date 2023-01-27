import Foundation
import UIKit

enum Tab: Int, CaseIterable {
    case game, encyclopedia, settings

    var item: UITabBarItem {
        switch self {
        case .game:
            return UITabBarItem(
                title: NSLocalizedString("Game", comment: "Game tab bar title"),
                image: UIImage(systemName: "gamecontroller"),
                tag: 0
            )

        case .encyclopedia:
            return UITabBarItem(
                title: NSLocalizedString("Encyclopedia", comment: "Encyclopedia tab bar title"),
                image: UIImage(systemName: "doc.text.magnifyingglass"),
                tag: 1
            )

        case .settings:
            return UITabBarItem(
                title: NSLocalizedString("Settings", comment: "Settings tab bar title"),
                image: UIImage(systemName: "gearshape"),
                tag: 2
            )
        }
    }
}


