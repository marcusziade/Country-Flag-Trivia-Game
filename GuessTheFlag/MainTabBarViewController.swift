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
            countriesViewController,
            settingsViewController
        ]
        selectedIndex = 2
    }
    
    // MARK: - Private
    
    private let settings: Settings
    
    private lazy var flagGameView: UIHostingController<FlagGameView> = {
        let view = UIHostingController(rootView: FlagGameView(manager: FlagGameManager(settings: self.settings)))
        view.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Game", comment: "Game tab bar title"),
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
        return view
    }()
    
    private let countriesViewController: UIHostingController<CountriesList> = {
        let view = UIHostingController(rootView: CountriesList(viewModel: CountryListVM()))
        view.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Encyclopedia", comment: "Encyclopedia tab bar title"),
            image: UIImage(systemName: "doc.text.magnifyingglass"),
            selectedImage: UIImage(systemName: "doc.text.magnifyingglass")
        )
        return view
    }()
    
    private lazy var settingsViewController: UINavigationController = {
        let viewController = SettingsViewController(model: SettingsViewModel(settings: settings))
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Settings", comment: "Settings tab bar title"),
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        return navigationController
    }()
}

import SwiftUI

struct MainTabBarController_Preview: PreviewProvider {
    static var previews: some View = createPreview(for: MainTabBarController(settings: Settings()), mode: .dark)
}

