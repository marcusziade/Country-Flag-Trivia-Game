//
//  UISplitViewController+Ext.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 26.6.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

// MARK: Reset the split view

extension UISplitViewController {

    func reset() {
        [Column.primary, Column.supplementary, Column.secondary].forEach {
            splitViewController?.setViewController(nil, for: $0)
        }
    }

    func closePrimary() {
        splitViewController?.setViewController(nil, for: .primary)
    }

    func closeSupplementary() {
        splitViewController?.setViewController(nil, for: .supplementary)
    }

    func closeSecondary() {
        splitViewController?.setViewController(nil, for: .secondary)
    }
}
