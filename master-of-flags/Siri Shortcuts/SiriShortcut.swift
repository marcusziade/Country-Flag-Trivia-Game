import Foundation
import UIKit

enum SiriShortcut: String {
    case game = "com.marcusziade.masterofflags.game"
    case encyclopedia = "com.marcusziade.masterofflags.encyclopedia"

    var activityType: String {
        return rawValue
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


