import Combine
import Foundation
import UIKit

final class SettingsViewModel: ObservableObject {

    let items = SettingsItems()

    let settings: Settings

    init(settings: Settings) {
        self.settings = settings
    }

    func setGameDifficulty(with bool: Bool) {
        settings.isHardModeEnabled = bool
    }

    // MARK: - Private

    private var cancellables = Set<AnyCancellable>()
}
