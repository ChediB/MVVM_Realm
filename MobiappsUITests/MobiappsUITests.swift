//
//  MobiappsUITests.swift
//  MobiappsUITests
//
//  Created by Chedi Baccari on 25/09/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import XCTest

class MobiappsUITests: XCTestCase {

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testTapTableViewRowToShowElementDetails() {
 
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["À l'orée de Maguuma"]/*[[".cells.staticTexts[\"À l'orée de Maguuma\"]",".staticTexts[\"À l'orée de Maguuma\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["À l'orée de Maguuma"].buttons["Share"].tap()
        
    }

}
