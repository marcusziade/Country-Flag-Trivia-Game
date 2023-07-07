import Foundation
import UIKit

struct SettingsItem {

    let id: SettingsItemType
    let image: String
    let color: UIColor
    let title: String
    let section: SettingsSection
    let viewController: ViewController?
    let url: URL?
}
