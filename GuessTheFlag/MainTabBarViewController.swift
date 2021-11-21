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
    
    // MARK: - Private
    
    private let flagGameView: UIHostingController<FlagGameView> = {
        let view = UIHostingController(rootView: FlagGameView( manager: FlagGameManager()))
        view.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
        return view
    }()
    
    private let countriesViewController: UIHostingController<CountriesList> = {
        let view = UIHostingController(rootView: CountriesList(viewModel: CountryListVM()))
        view.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "doc.text.magnifyingglass"),
            selectedImage: UIImage(systemName: "doc.text.magnifyingglass")
        )
        return view
    }()
    
    private let aboutViewController: UINavigationController = {
        let viewController = AboutViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "ellipsis.circle"),
            selectedImage: UIImage(systemName: "ellipsis.circle.fill")
        )
        return navigationController
    }()
}

import SwiftUI

struct MainTabBarController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: MainTabBarController(), mode: .dark)
}

