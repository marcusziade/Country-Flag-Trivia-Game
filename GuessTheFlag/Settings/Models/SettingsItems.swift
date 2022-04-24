//
//  SettingsItems.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

struct SettingsItems {
    
    private let data: [SettingsItem] = [
        SettingsItem(
            image: "gamecontroller",
            color: .systemPurple,
            title: NSLocalizedString("Enable Hard Mode", comment: "Enable hard mode title"),
            section: .game,
            viewController: nil,
            url: nil
        ),
        
        SettingsItem(
            image: "info.circle",
            color: .systemBlue,
            title: NSLocalizedString("About", comment: "About title"),
            section: .general,
            viewController: AboutViewController(),
            url: nil
        ),
        
        SettingsItem(
            image: "dollarsign.square",
            color: .systemGreen,
            title: NSLocalizedString("Tip Jar", comment: "Tip Jar title"),
            section: .support,
            viewController: ViewController(),
            url: nil
        ),
        
        SettingsItem(
            image: "person.wave.2",
            color: .systemYellow,
            title: NSLocalizedString("Send Feedback", comment: "Send Feedback title"),
            section: .support,
            viewController: nil,
            url: URL(string: "https://twitter.com/ziademarcus")!
        ),
        
        SettingsItem(
            image: "text.badge.star",
            color: .systemOrange,
            title: NSLocalizedString("Rate Master of Flags", comment: "Rate title"),
            section: .support,
            viewController: nil,
            url: nil
        ),
    ]
    
    let general: [SettingsItem]
    let game: [SettingsItem]
    let support: [SettingsItem]
    
    init() {
        general = data.filter { $0.section == .general }
        game = data.filter { $0.section == .game }
        support = data.filter { $0.section == .support }
    }
}
