//
//  MainTabBarViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {
    
    // MARK: - UI Components
    let flagGameView: UIHostingController<FlagsGameView> = {
        let view = UIHostingController(rootView: FlagsGameView())
        view.tabBarItem = UITabBarItem(title: "Flag Game", image: UIImage(systemName: "globe"), selectedImage: UIImage(systemName: "globe"))
        return view
    }()
    
    let countriesViewController: NavigationController = {
        let viewController = CountriesListViewController()
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: "Countries", image: UIImage(systemName: "doc"), selectedImage: UIImage(systemName: "doc.fill"))
        return navigationController
    }()

    let aboutViewController: AboutViewController = {
        let viewController = AboutViewController()
        viewController.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "ellipsis.circle"), selectedImage: UIImage(systemName: "ellipsis.circle"))
        return viewController
    }()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .label
        viewControllers = [
            flagGameView,
            countriesViewController,
            aboutViewController
        ]
        selectedIndex = 1
    }
}

import SwiftUI

struct MainTabBarController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: MainTabBarController(), mode: .dark)
}

