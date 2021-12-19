//
//  MasterofFlagsUITests.swift
//  MasterofFlagsUITests
//
//  Created by Marcus Ziadé on 19.12.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import XCTest

final class MasterofFlagsUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func testGameView() {
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
    
    func testEncyclopediaView() {
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
