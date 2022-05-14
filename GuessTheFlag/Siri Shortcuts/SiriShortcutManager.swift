//
//  SiriShortcutManager.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 8.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import CoreSpotlight
import Foundation
import Intents
import MobileCoreServices
import UIKit

final class SiriShortcutManager {
    
    func createShortcut(for shortcut: SiriShortcut) -> NSUserActivity {
        return NSUserActivity(activityType: shortcut.activityType).configure {
            $0.title = shortcut.title
            let attributes = CSSearchableItemAttributeSet(contentType: .item)
            attributes.contentDescription = shortcut.description
            attributes.thumbnailData = shortcut.thumbnail.jpegData(compressionQuality: 1.0)
            $0.contentAttributeSet = attributes
            $0.suggestedInvocationPhrase = shortcut.phrase
            $0.persistentIdentifier = NSUserActivityPersistentIdentifier(shortcut.activityType)
            $0.isEligibleForSearch = true
            $0.isEligibleForPrediction = true
        }
    }
    
    func handleSiriShortcut(
        _ shortcut: SiriShortcut,
        window: UIWindow?
    ) {
        guard let tabBarController = window?.rootViewController as? MainTabBarController else {
            assertionFailure("Failed to find tab bar controller")
            return
        }
        
        tabBarController.handleSiriShortcut(shortcut)
    }
}
