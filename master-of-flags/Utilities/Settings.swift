//
//  Settings.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Foundation

class Settings {

    static var parentalGateUnlocked: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "parentalGateUnlocked")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "parentalGateUnlocked")
        }
    }
    
    var isHardModeEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isHardModeEnabled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isHardModeEnabled")
        }
    }
}
