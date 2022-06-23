//
//  TrackedViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 23/06/22.
//

import XCTest

class TrackedViewUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        app.buttons["TrackingTabBar"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TrackedView_TextField_NoResult() {
        app.textFields["TrackedViewSearchTextField"].tap()
        
        app.keys["A"].tap()
        app.keys["a"].tap()
        app.keys["a"].tap()
        app.keys["a"].tap()
        app.keys["a"].tap()

        app.buttons["Return"].tap()
        
        let noResult = app.staticTexts["TrackedViewNoResult"]
        
        XCTAssertTrue(noResult.exists)
    }
    
    func test_TrackedView_TextField_Result() {
        app.textFields["TrackedViewSearchTextField"].tap()
        
        app.keys["A"].tap()
        app.keys["p"].tap()
        app.keys["p"].tap()
        app.keys["l"].tap()
        app.keys["e"].tap()

        app.buttons["Return"].tap()
        
        let noResult = app.staticTexts["TrackedViewNoResult"]
        
        XCTAssertFalse(noResult.exists)
    }
}
