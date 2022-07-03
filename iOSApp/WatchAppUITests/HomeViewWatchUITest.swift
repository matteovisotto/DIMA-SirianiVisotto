//
//  HomeViewWatchUITest.swift
//  WatchAppUITests
//
//  Created by Tia on 02/07/22.
//

import XCTest

class HomeViewWatchUITest: XCTestCase {

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

    func test_Watch_HomeView_MostTracked_AccessAndGoBack() throws {
        let tracked = app.buttons["HomeViewMostTrackedWatch"]
        XCTAssertTrue(tracked.exists)
        let trackedText = tracked.label
        
        tracked.tap()
        XCTAssertEqual(trackedText.lowercased(), app.staticTexts.firstMatch.label.lowercased())
        
        app.buttons.firstMatch.tap()
        let trackedNew = app.buttons["HomeViewMostTrackedWatch"]
        XCTAssertTrue(trackedNew.exists)
    }
    
    func test_Watch_HomeView_TopTen_AccessAndGoBack() throws {
        let top = app.buttons["HomeViewTopTenWatch"]
        XCTAssertTrue(top.exists)
        let topText = top.label
        
        top.tap()
        XCTAssertEqual(topText.lowercased(), app.staticTexts.firstMatch.label.lowercased())
        
        app.buttons.firstMatch.tap()
        let topNew = app.buttons["HomeViewTopTenWatch"]
        XCTAssertTrue(topNew.exists)
    }
    
    func test_Watch_HomeView_Tracked_AccessAndGoBack() throws {
        let tracked = app.buttons["HomeViewTrackedWatch"].waitForExistence(timeout: 10)
        
        if (tracked) {
            let trackedText = app.buttons["HomeViewTrackedWatch"].label
            
            app.buttons["HomeViewTrackedWatch"].tap()
            
            XCTAssertEqual(trackedText.lowercased(), app.staticTexts.firstMatch.label.lowercased())
            
            app.buttons.firstMatch.tap()
            let topNew = app.buttons["HomeViewTopTenWatch"]
            XCTAssertTrue(topNew.exists)
        }
    }
}
