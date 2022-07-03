//
//  ProductViewiPadUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 02/07/22.
//

import XCTest

class ProductViewiPadUITest: XCTestCase {

    let app = XCUIApplication()
    var userIsLogged = true
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .phone, "Only test for iPhone")
        app.launch()
        
        if (app.staticTexts["HomeViewLastProductText"].exists) {
            userIsLogged = false
        }
        app.scrollViews.buttons["HomeViewMostrTrackedButton0"].tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
    }
}
