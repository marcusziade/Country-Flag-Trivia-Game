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
        
        // This is needed when the app is opened from a terminated state
        if let shortcutItem = connectionOptions.shortcutItem {
            quickActionManager.handleShortcutItem(shortcutItem, window: window) { _ in }
        }
    }
    
    // MARK: - Quick actions
    
    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        quickActionManager.handleShortcutItem(shortcutItem, window: window, completionHandler: completionHandler)
    }
    
    // MARK: - Private
    
    private let settings = Settings()
    private let quickActionManager = QuickActionManager()
}
