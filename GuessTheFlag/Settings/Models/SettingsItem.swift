//
//  SettingsItem.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 24.4.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

struct SettingsItem {
    
    let image: String
    let color: UIColor
    let title: String
    let section: SettingsSection
    let viewController: ViewController?
    let url: URL?
}
