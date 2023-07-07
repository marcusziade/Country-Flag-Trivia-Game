import XCTest

@testable import Master_of_Flags

final class FlagGameManager_Tests: XCTestCase {
    
    var sut: FlagGameManager!
    var settings: Settings!
    
    override func setUp() {
        super.setUp()
        settings = Settings()
        sut = FlagGameManager(settings: settings)
    }
    
    override func tearDown() {
        sut = nil
        settings = nil
        super.tearDown()
    }
    
    func testPickerValueChangeUpdatesRegion() {
        sut.activePickerValue = 1
        XCTAssertEqual(sut.selectedRegion, .asia)
    }
    
    func testRegionChangeUpdatesProperties() {
        sut.selectedRegion = .asia
        XCTAssertEqual(sut.score, UserDefaults.standard.integer(forKey: Region.asia.flagGameScoreKey))
        XCTAssertEqual(sut.playerLevel, UserDefaults.standard.integer(forKey: Region.asia.flagGamePlayerLevelKey))
        XCTAssertEqual(sut.streak, UserDefaults.standard.integer(forKey: Region.asia.flagGameStreakKey))
        XCTAssertEqual(Set(sut.countries), Set(Region.asia.countries))
    }

    func testAskQuestionShufflesCountriesAndSetsCorrectAnswer() {
        let originalCountries = sut.countries
        sut.askQuestion()
        XCTAssertNotEqual(sut.countries, originalCountries)
        XCTAssert(sut.correctAnswer >= 0 && sut.correctAnswer < sut.countries.count)
    }
    
    func testFlagTappedUpdatesScore() {
        let initialScore = sut.score
        let initialStreak = sut.streak
        
        sut.correctAnswer = 0
        sut.flagTapped(0)
        XCTAssertEqual(sut.score, initialScore + 15)
        XCTAssertEqual(sut.streak, initialStreak + 1)
        
        sut.correctAnswer = 0
        sut.flagTapped(1)
        XCTAssertEqual(sut.score, initialScore + 15 - 10)
        XCTAssertEqual(sut.streak, 0)
    }
}
