//
//  HapticEngine.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 30.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import UIKit

class HapticEngine {
    static let soft = UIImpactFeedbackGenerator(style: .soft)
    static let notification = UINotificationFeedbackGenerator()
    static let rigid = UIImpactFeedbackGenerator(style: .rigid)
    static let select = UISelectionFeedbackGenerator()
    static let result = UINotificationFeedbackGenerator()
}
