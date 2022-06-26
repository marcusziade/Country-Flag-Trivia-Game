//
//  Tab.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 8.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

enum Tab: Int, CaseIterable {
    case game, encyclopedia, settings

    var item: UITabBarItem {
        switch self {
        case .game:
            return UITabBarItem(
                title: title,
                image: icon,
                tag: 0
            )

        case .encyclopedia:
            return UITabBarItem(
                title: title,
                image: icon,
                tag: 1
            )

        case .settings:
            return UITabBarItem(
                title: title,
                image: icon,
                tag: 2
            )
        }
    }

    var title: String {
        switch self {
        case .game:
            return NSLocalizedString("Game", comment: "Game tab bar title")
        case .encyclopedia:
            return NSLocalizedString("Encyclopedia", comment: "Encyclopedia tab bar title")
        case .settings:
            return NSLocalizedString("Settings", comment: "Settings tab bar title")
        }
    }

    var icon: UIImage {
        switch self {
        case .game:
            return UIImage(systemName: "gamecontroller")!
        case .encyclopedia:
            return UIImage(systemName: "doc.text.magnifyingglass")!
        case .settings:
            return UIImage(systemName: "gearshape")!
        }
    }
}
