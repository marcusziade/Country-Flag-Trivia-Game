import Foundation

struct SettingsItems {

    private let items: [SettingsItem] = SettingsItemType.allCases.map {
        SettingsItem(
            id: $0.id,
            image: $0.image,
            color: $0.color,
            title: $0.title,
            section: $0.section,
            viewController: $0.viewController,
            url: $0.url
        )
    }

    let general: [SettingsItem]
    let game: [SettingsItem]
    let support: [SettingsItem]

    init() {
        general = items.filter { $0.section == .general }
        game = items.filter { $0.section == .game }
        support = items.filter { $0.section == .support }
    }
}
