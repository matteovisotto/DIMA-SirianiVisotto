//
//  SeeAllViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 23/06/22.
//

import XCTest

class SeeAllViewUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        app.buttons["HomeTabBar"].tap()
        
        let seeAllButton = app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(seeAllButton)
        
        app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SeeAllView_OpenCategories () {
        let seeAllButtonCategories = app.buttons["SeeAllViewCategoriesButton"]
        
        XCTAssertTrue(seeAllButtonCategories.exists)
        
        app.buttons["SeeAllViewCategoriesButton"].tap()
        
        let categories = app.staticTexts["FilterViewSelectMoreCategories"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(categories)
    }
    
    func test_SeeAllView_OpenCategoriesAndCloseIt() {
        app.buttons["SeeAllViewCategoriesButton"].tap()
        
        let categories = app.staticTexts["FilterViewSelectMoreCategories"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(categories)
        
        app.buttons["FilterViewCloseCategories"].tap()
        
        let seeAllName = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(seeAllName.exists)
    }
}
