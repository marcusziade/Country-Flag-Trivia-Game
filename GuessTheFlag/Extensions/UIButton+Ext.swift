//
//  UIButton+Ext.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 7.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Button configurations

extension UIButton.Configuration {

    /// The button config for the tip jar legal footer buttons
    /// - Parameter title: The title string to use for the button title
    static func tipJarLegal(with title: String) -> Self {
        var config = UIButton.Configuration.filled()
        config.title = NSLocalizedString(title, comment: "")
        config.baseForegroundColor = .white
        config.background.backgroundColor = .systemBlue
        config.cornerStyle = .medium
        config.buttonSize = .small
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        return config
    }
}
