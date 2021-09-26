//
//  MainTabBarViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 17.10.2020.
//  Copyright © 2020 Marcus Ziadé. All rights reserved.
//

import UIKit
import SwiftUI

final class MainTabBarController: UITabBarController {
    
    // MARK: - UI Components

    let flagGameView: UIHostingController<FlagsGameView> = {
        let view = UIHostingController(rootView: FlagsGameView())
        view.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
        return view
    }()
    
    let countriesViewController: UIHostingController<CountriesList> = {
        let view = UIHostingController(rootView: CountriesList())
        view.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "doc.text.magnifyingglass"),
            selectedImage: UIImage(systemName: "doc.text.magnifyingglass")
        )
        return view
    }()

    let aboutViewController: AboutViewController = {
        let viewController = AboutViewController()
        viewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "ellipsis.circle"),
            selectedImage: UIImage(systemName: "ellipsis.circle.fill")
        )
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

