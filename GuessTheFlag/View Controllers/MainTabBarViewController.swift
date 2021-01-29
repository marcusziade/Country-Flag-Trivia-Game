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
    
    let countriesViewController: UINavigationController = {
        let viewController = CountriesListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: "Countries", image: UIImage(systemName: "doc"), selectedImage: UIImage(systemName: "doc.fill"))
        return navigationController
    }()
    
    let aboutView: UIHostingController<About> = {
        let view = UIHostingController(rootView: About())
        view.tabBarItem = UITabBarItem(title: "About", image: UIImage(systemName: "ellipsis.circle"), selectedImage: UIImage(systemName: "ellipsis.circle"))
        return view
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            flagGameView,
//            countriesViewController,
            aboutView
        ]
    }
}

import SwiftUI

struct MainTabBarController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: MainTabBarController())
}

