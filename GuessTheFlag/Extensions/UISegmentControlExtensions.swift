//
//  UISegmentControlExtensions.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    convenience init<T: CaseIterable>(type: T.Type) where T: RawRepresentable, T.RawValue == String {
        let allOptions = type.allCases.map(\.rawValue)
        self.init(items: allOptions)
    }
}
