//
//  SettingsViewController.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

final class SettingsViewController: ViewController {
    
    init(model: SettingsViewModel) {
        self.model = model
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("Settings", comment: "Settings nav title")
        
        view.addAndConstrainSubview(collectionView) {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Private
    
    private let model: SettingsViewModel
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout).configure {
        $0.dataSource = self
        $0.delegate = self
        
        $0.registerCell(SettingsRegularCell.self)
        $0.registerCell(SettingsHardModeCell.self)
    }
    
    private var viewLayout: UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let config = UICollectionLayoutListConfiguration(appearance: .grouped)
            
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

// MARK: - UICollectionViewDataSource

extension SettingsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SettingsSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        switch section {
        case .general:
            return model.items.general.count
        case .game:
            return model.items.game.count
        case .support:
            return model.items.support.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .general:
            return collectionView.dequeueCell(SettingsRegularCell.self, forIndexPath: indexPath).configure {
                $0.configure(with: model.items.general[indexPath.item])
            }
        case .game:
            return collectionView.dequeueCell(SettingsHardModeCell.self, forIndexPath: indexPath).configure {
                $0.configure(with: model.items.game[indexPath.item], isEnabled: model.settings.isHardModeEnabled)
                $0.onHardModeToggled = { [unowned self] in
                    model.settings.isHardModeEnabled = $0
                }
            }
        case .support:
            return collectionView.dequeueCell(SettingsRegularCell.self, forIndexPath: indexPath).configure {
                $0.configure(with: model.items.support[indexPath.item])
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SettingsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        switch section {
        case .general:
            if let viewController = model.items.general[indexPath.item].viewController {
                navigationController?.pushViewController(viewController, animated: true)
            } else {
                break
            }
        case .game:
            break
        case .support:
            if let viewController = model.items.support[indexPath.item].viewController {
                print(viewController)
                navigationController?.pushViewController(viewController, animated: true)
            } else {
                UIApplication.shared.open(model.items.support[indexPath.item].url ?? URL(string: "https://twitter.com/ziademarcus")!)
            }
        }
    }
}
