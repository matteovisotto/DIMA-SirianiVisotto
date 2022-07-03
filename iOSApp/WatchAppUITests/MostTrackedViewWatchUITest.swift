//
//  TrackedViewWatchUITest.swift
//  WatchAppUITests
//
//  Created by Tia on 02/07/22.
//

import XCTest

class MostTrackedViewWatchUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Watch_MostTracked_ProductButton_AccessAndGoBack() throws {
        let tracked = app.buttons["HomeViewMostTrackedWatch"]
        XCTAssertTrue(tracked.exists)
        let trackedText = tracked.label
        
        tracked.tap()
        
        app.buttons.element(boundBy: 1).tap()
        let product = app.staticTexts["ProductViewNameWatch"]
        XCTAssertTrue(product.exists)
        
        app.buttons.firstMatch.tap()
        
        XCTAssertEqual(trackedText.lowercased(), app.staticTexts.firstMatch.label.lowercased())
    }
}
