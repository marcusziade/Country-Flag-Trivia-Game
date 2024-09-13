import XCTest

final class MasterofFlagsUITests: XCTestCase {
    
    @MainActor override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    @MainActor func testGameView() {
        let tabBar = XCUIApplication().tabBars
        let firstTab = tabBar.buttons.element(boundBy: 0)
        
        firstTab.tap()
        
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait
        snapshot("game.portrait")
        
        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeRight
        snapshot("game.landscape.right")

        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeLeft
        snapshot("game.landscape.left")
    }
    
    @MainActor func testEncyclopediaView() {
        let tabBar = XCUIApplication().tabBars
        let secondTab = tabBar.buttons.element(boundBy: 1)
        
        secondTab.tap()
        
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait
        snapshot("encyclopedia.portrait")
        
        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeRight
        snapshot("encyclopedia.landscape.right")

        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeLeft
        snapshot("encyclopedia.Landscape.left")
    }
}
