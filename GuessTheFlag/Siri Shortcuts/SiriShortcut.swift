//
//  SiriShortcut.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 8.5.2022.
//  Copyright © 2022 Marcus Ziadé. All rights reserved.
//

import Foundation
import UIKit

enum SiriShortcut {
    case game, encyclopedia
    
    var activityType: String {
        switch self {
        case .game:
            return "com.marcusziade.masterofflags.game"
        case .encyclopedia:
            return "com.marcusziade.masterofflags.encyclopedia"
        }
    }
    
    var thumbnail: UIImage {
        switch self {
        case .game:
            return UIImage(systemName: "gamecontroller")!
        case .encyclopedia:
            return UIImage(systemName: "doc.text.magnifyingglass")!
        }
    }
    
    var title: String {
        switch self {
        case .game:
            return "Launch flag game"
        case .encyclopedia:
            return "Launch the encyclopedia"
        }
    }
    
    var description: String {
        switch self {
        case .game:
            return "Learn and memorise more flags"
        case .encyclopedia:
            return "Study more countries"
        }
    }
    
    var phrase: String {
        switch self {
        case .game:
            return "Launch flag game"
        case .encyclopedia:
            return "Launch flag encyclopedia"
        }
    }
}
