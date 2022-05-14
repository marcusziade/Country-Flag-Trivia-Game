//
//  Settings.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Foundation

final class Settings {

    var isHardModeEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isHardModeEnabled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isHardModeEnabled")
        }
    }
}
