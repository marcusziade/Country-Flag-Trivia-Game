//
//  SplitViewDelegate.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 26.6.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

final class SplitViewDelegate: NSObject, UISplitViewControllerDelegate {

    func splitViewController(
        _ splitViewController: UISplitViewController,
        showDetail vc: UIViewController,
        sender: Any?
    ) -> Bool {
        guard
            splitViewController.isCollapsed,
            let tabBarController = splitViewController.viewControllers.first as? UITabBarController,
            let navigationController = tabBarController.selectedViewController as? UINavigationController
        else {
            return false
        }

        var viewControllerToPush = vc
        if let otherNavigationController = vc as? UINavigationController {
            if let topViewController = otherNavigationController.topViewController {
                viewControllerToPush = topViewController
            }
        }
        viewControllerToPush.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewControllerToPush, animated: true)

        return true
    }
}
