//
//  SidebarVC.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 26.6.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

final class SidebarVC: ViewController {

    init(settings: Settings) {
        self.settings = settings
        super.init()
    }

    override func loadView() {
        super.loadView()

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    // MARK: Private

    private let settings: Settings

    private lazy var collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.registerCell(UICollectionViewListCell.self)
        return view
    }()
}

// MARK: UICollectionViewDataSource

extension SidebarVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Tab.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueCell(UICollectionViewListCell.self, forIndexPath: indexPath)
            .configure {
                let item = Tab.allCases[indexPath.item]
                var content = $0.defaultContentConfiguration()
                content.image = item.icon
                content.text = item.title
                $0.contentConfiguration = content
            }
    }
}

// MARK: UICollectionViewDelegate

extension SidebarVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = Tab.allCases[indexPath.item]
        let viewController: UIViewController
        switch item {
        case .game:
            viewController = UIHostingController(rootView: FlagGameView(manager: FlagGameManager(settings: self.settings)))
        case .encyclopedia:
            viewController = UIHostingController(rootView: CountriesList(viewModel: CountryListVM()))
        case .settings:
            viewController = UINavigationController(
                rootViewController: SettingsViewController(model: SettingsViewModel(settings: self.settings))
            )
        }

        splitViewController?.reset()

        if splitViewController?.traitCollection.horizontalSizeClass == .compact {
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let sidebarVC = SidebarVC(settings: settings)
            switch item {
            case .game:
//                splitViewController?.closePrimary()
                splitViewController?.setViewController(nil, for: .primary)
                splitViewController?.hide(.primary)
                splitViewController?.setViewController(viewController, for: .secondary)
                splitViewController?.setViewController(sidebarVC, for: .supplementary)
            case .encyclopedia:
                splitViewController?.reset()
                splitViewController?.setViewController(sidebarVC, for: .primary)
                splitViewController?.setViewController(
                    UIHostingController(rootView: FlagGameView(manager: FlagGameManager(settings: self.settings))),
                    for: .supplementary
                )
            case .settings:
                splitViewController?.reset()
                splitViewController?.setViewController(sidebarVC, for: .primary)
                splitViewController?.setViewController(
                    SettingsViewController(model: SettingsViewModel(settings: self.settings)),
                    for: .supplementary
                )
//                splitViewController?.setViewController(nil, for: .secondary)
                splitViewController?.hide(.secondary)
            }
        }
    }
}
