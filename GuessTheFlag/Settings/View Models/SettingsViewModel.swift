//
//  SettingsViewModel.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 21.11.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class SettingsViewModel: ObservableObject {
    
    let items = SettingsItems()
    
    let settings: Settings
    
    init(settings: Settings) {
        self.settings = settings
    }
    
    var viewLayout: UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let config = UICollectionLayoutListConfiguration(appearance: .grouped)
            
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func setGameDifficulty(with bool: Bool) {
        settings.isHardModeEnabled = bool
    }
    
    // MARK: - Private
    
    private var cancellables = Set<AnyCancellable>()
}
