import Foundation
import UIKit

enum SettingsItemType: CaseIterable {
    case hardMode, about, tipJar, feedback, rate, share

    var id: SettingsItemType {
        return self
    }

    var image: String {
        switch self {
        case .hardMode:
            return "gamecontroller"
        case .about:
            return "info.circle"
        case .tipJar:
            return "dollarsign.square"
        case .feedback:
            return "person.wave.2"
        case .rate:
            return "text.badge.star"
        case .share:
            return "square.and.arrow.up"
        }
    }

    var color: UIColor {
        switch self {
        case .hardMode:
            return .systemPurple
        case .about:
            return .systemBlue
        case .tipJar:
            return .systemGreen
        case .feedback:
            return .systemYellow
        case .rate:
            return .systemOrange
        case .share:
            return .systemPink
        }
    }

    var title: String {
        switch self {
        case .hardMode:
            return NSLocalizedString("Enable Hard Mode", comment: "Enable hard mode title")
        case .about:
            return NSLocalizedString("About", comment: "About title")
        case .tipJar:
            return NSLocalizedString("Tip Jar", comment: "Tip Jar title")
        case .feedback:
            return NSLocalizedString("Send Feedback", comment: "Send Feedback title")
        case .rate:
            return NSLocalizedString("Rate Master of Flags", comment: "Rate title")
        case .share:
            return NSLocalizedString("Share Master of Flags", comment: "Share title")
        }
    }

    var section: SettingsSection {
        switch self {
        case .hardMode:
            return .game
        case .about:
            return .general
        case .tipJar:
            return .support
        case .feedback:
            return .support
        case .rate:
            return .support
        case .share:
            return .support
        }
    }

    var viewController: ViewController? {
        switch self {
        case .hardMode:
            return nil
        case .about:
            return AboutViewController()
        case .tipJar:
            return TipJarViewController()
        case .feedback:
            return nil
        case .rate:
            return nil
        case .share:
            return nil
        }
    }

    var url: URL? {
        switch self {
        case .hardMode:
            return nil
        case .about:
            return nil
        case .tipJar:
            return nil
        case .feedback:
            return URL(string: "https://twitter.com/ziademarcus")!
        case .rate:
            return nil
        case .share:
            return nil
        }
    }
}
