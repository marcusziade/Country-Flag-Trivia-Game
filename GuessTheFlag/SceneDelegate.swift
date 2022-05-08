//
//  SceneDelegate.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 13.10.2019.
//  Copyright © 2019 Marcus Ziadé. All rights reserved.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            quickActionManager.create()
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = MainTabBarController(settings: settings)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        handleShortcutsIfAppTerminated(for: connectionOptions)
    }
    
    // MARK: - Quick actions
    
    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        quickActionManager.handleShortcutItem(shortcutItem, window: window, completionHandler: completionHandler)
    }
    
    // MARK: - Siri shortcuts
    
    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        guard let shortcut = SiriShortcut(rawValue: userActivityType) else { return }
        siriShortcutManager.handleSiriShortcut(shortcut, window: window)
    }
    
    // MARK: - Private
    
    private let settings = Settings()
    private let quickActionManager = QuickActionManager()
    private let siriShortcutManager = SiriShortcutManager()
    
    /// Configures shortcuts when they are launched when the app is terminated
    private func handleShortcutsIfAppTerminated(for options: UIScene.ConnectionOptions) {
        // Quick actions
        if let shortcutItem = options.shortcutItem {
            quickActionManager.handleShortcutItem(shortcutItem, window: window) { _ in }
        }
        
        // Siri shortcuts
        if
            let activity = options.userActivities.map(\.activityType).first,
            let shortcut = SiriShortcut(rawValue: activity)
        {
            siriShortcutManager.handleSiriShortcut(shortcut, window: window)
        }
    }
}
