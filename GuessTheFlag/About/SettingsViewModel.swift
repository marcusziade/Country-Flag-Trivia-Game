//
//  SettingsViewModel.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 21.11.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Combine
import Foundation

final class SettingsViewModel: ObservableObject {
    
    @Published var isHapticsEnabled = UserDefaults.standard.bool(forKey: "isHapticsEnabled")
    
    init() {
        $isHapticsEnabled
            .sink { UserDefaults.standard.set($0, forKey: "isHapticsEnabled") }
            .store(in: &cancellables)
    }
    
    // MARK: - Private
    
    private var cancellables = Set<AnyCancellable>()
}
