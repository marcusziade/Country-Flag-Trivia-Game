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

    func setGameDifficulty(with bool: Bool) {
        settings.isHardModeEnabled = bool
    }

    // MARK: - Private

    private var cancellables = Set<AnyCancellable>()
}
