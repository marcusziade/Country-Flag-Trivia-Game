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
    }
    
    // MARK: - Quick actions
    
    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        handleShortcutItem(shortcutItem, completionHandler: completionHandler)
    }
    
    // MARK: - Private
    
    private let settings = Settings()
    private let quickActionManager = QuickActionManager()
    
    private func handleShortcutItem(
        _ item: UIApplicationShortcutItem?,
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
}
