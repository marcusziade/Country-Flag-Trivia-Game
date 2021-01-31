//
//  NSLayoutConstraintsExtensions.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 31.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    func named(_ name: String) -> NSLayoutConstraint {
        self.identifier = name
        return self
    }

    func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
