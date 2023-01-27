import SwiftUI
import UIKit

final class MainTabBarController: UITabBarController {

    init(settings: Settings) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .label
        viewControllers = [
            flagGameView,
            encyclopediaView,
            settingsViewController,
        ]
        selectedIndex = 0
    }

    func handleShortcut(_ shortcut: QuickActionManager.ShortcutIdentifier) {
        switch shortcut {
        case .game:
            selectedIndex = 0
        case .encyclopedia:
            selectedIndex = 1
        }
    }

    func handleSiriShortcut(_ shortcut: SiriShortcut) {
        switch shortcut {
        case .game:
            selectedIndex = 0
        case .encyclopedia:
            selectedIndex = 1
        }
    }

    // MARK: - Private

    private let settings: Settings

    private let siriShortcutManager = SiriShortcutManager()

    private lazy var flagGameView = UIHostingController(
        rootView: FlagGameView(manager: FlagGameManager(settings: self.settings))
    ).configure {
        $0.tabBarItem = Tab.game.item
    }

    private let encyclopediaView = UIHostingController(
        rootView: CountriesList(viewModel: CountryListVM())
    ).configure {
        $0.tabBarItem = Tab.encyclopedia.item
    }

    private lazy var settingsViewController = UINavigationController(
        rootViewController: SettingsViewController(model: SettingsViewModel(settings: self.settings))
    ).configure {
        $0.tabBarItem = Tab.settings.item
    }
}

extension MainTabBarController {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.8)
        guard let tab = Tab(rawValue: item.tag) else { return }

        let activity: NSUserActivity?

        switch tab {
        case .game:
            activity = siriShortcutManager.createShortcut(for: .game)
        case .encyclopedia:
            activity = siriShortcutManager.createShortcut(for: .encyclopedia)
        case .settings:
            activity = nil
        }

        view.userActivity = activity
        activity?.becomeCurrent()
    }
}

struct MainTabBarController_Preview: PreviewProvider {
    static var previews: some View = Preview(for: MainTabBarController(settings: Settings()))
}


