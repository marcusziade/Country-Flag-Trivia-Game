//
//  MainTabBarViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - UI Components
    let countriesViewController: UINavigationController = {
        let viewController = CountriesListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: "Countries", image: UIImage(systemName: "doc"), selectedImage: UIImage(systemName: "doc.fill"))
        return navigationController
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            countriesViewController,
        ]
    }
}
