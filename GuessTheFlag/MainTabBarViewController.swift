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
    
    init(settings: Settings) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .label
        viewControllers = [
            flagGameView,
            encyclopediaView,
            settingsViewController
        ]
        selectedIndex = 2
    }
    
    // MARK: - Private
    
    private let settings: Settings
    
    private lazy var flagGameView = UIHostingController(
        rootView: FlagGameView(manager: FlagGameManager(settings: self.settings))
    ).configure {
        $0.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Game", comment: "Game tab bar title"),
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
    }
    
    private let encyclopediaView = UIHostingController(
        rootView: CountriesList(viewModel: CountryListVM())
    ).configure {
        $0.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Encyclopedia", comment: "Encyclopedia tab bar title"),
            image: UIImage(systemName: "doc.text.magnifyingglass"),
            selectedImage: UIImage(systemName: "doc.text.magnifyingglass")
        )
    }
    
    private lazy var settingsViewController = UINavigationController(
        rootViewController: SettingsViewController(model: SettingsViewModel(settings: self.settings))
    ).configure {
        $0.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Settings", comment: "Settings tab bar title"),
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
    }
}

import SwiftUI

struct MainTabBarController_Preview: PreviewProvider {
    static var previews: some View = Preview(for: MainTabBarController(settings: Settings()))
}

