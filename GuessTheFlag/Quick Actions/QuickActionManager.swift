//
//  QuickActionManager.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 8.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

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
    
    // MARK: - Private
    
    private let application = UIApplication.shared
}
