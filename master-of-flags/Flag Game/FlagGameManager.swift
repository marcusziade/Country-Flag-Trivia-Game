import Combine
import Foundation
import SwiftUI

final class FlagGameManager: ObservableObject {

    @Published var countries: [String] = Region.europe.countries

    @Published var activePickerValue = 0

    @Published var showingScore = false
    @Published var scoreTitle = ""
    @Published var alertMessage = ""

    @Published var correctAnswer = Int.random(in: 0...2)

    @Published var dragAmount = CGSize.zero
    @Published var rotation: Double = 1

    @Published var selectedRegion: Region = .europe

    @Published var score = 0
    @Published var playerLevel = 0
    @Published var streak = 0

    let regions = [Region.europe, Region.asia, Region.africa, Region.americas, Region.world]

    let flagGridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    let settings: Settings

    init(settings: Settings) {
        self.settings = settings

        $activePickerValue
            .removeDuplicates()
            .sink { [unowned self] in
                switch $0 {
                case 0: selectedRegion = .europe
                case 1: selectedRegion = .asia
                case 2: selectedRegion = .africa
                case 3: selectedRegion = .americas
                default: selectedRegion = .world
                }
            }
            .store(in: &cancellables)

        $selectedRegion
            .sink { [unowned self] in
                UISelectionFeedbackGenerator().selectionChanged()

                score = UserDefaults.standard.integer(forKey: $0.flagGameScoreKey)
                playerLevel = UserDefaults.standard.integer(forKey: $0.flagGamePlayerLevelKey)
                streak = UserDefaults.standard.integer(forKey: $0.flagGameStreakKey)

                countries = $0.countries

                askQuestion()
            }
            .store(in: &cancellables)
    }

    var isHardModeEnabled: Bool {
        return UserDefaults.standard.bool(forKey: "isHardModeEnabled")
    }

    func flagTapped(_ number: Int) {
        HapticEngine.select.selectionChanged()
        withAnimation(.interpolatingSpring(mass: 40, stiffness: 500, damping: 200, initialVelocity: 2.2)) {
            rotation += 360
        }

        number == correctAnswer
            ? win(for: number)
            : lose(for: number)

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: isHardModeEnabled ? 0...7 : 0...2)
    }

    // MARK: - Private

    private var cancellables = Set<AnyCancellable>()

    private func win(for number: Int) {
        scoreTitle = "Correct ✅\n" + "+15 XP!"
        alertMessage = "That's the flag of \(countries[number])"
        score += 15
        streak += 1
        UserDefaults.standard.set(score, forKey: selectedRegion.flagGameScoreKey)
        UserDefaults.standard.set(streak, forKey: selectedRegion.flagGameStreakKey)

        if score >= 450 {
            playerLevel += 1
            score = 0
            UserDefaults.standard.set(playerLevel, forKey: selectedRegion.flagGamePlayerLevelKey)
            UserDefaults.standard.set(score, forKey: selectedRegion.flagGameScoreKey)
        }
    }

    private func lose(for number: Int) {
        scoreTitle = "Wrong ❌\n" + "-10 XP"
        alertMessage = "That's the flag of \(countries[number])"
        score -= 10
        streak = 0
        UserDefaults.standard.set(score, forKey: selectedRegion.flagGameScoreKey)
        UserDefaults.standard.set(streak, forKey: selectedRegion.flagGameStreakKey)
    }
}
