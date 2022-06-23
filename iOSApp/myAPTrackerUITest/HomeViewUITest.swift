//
//  HomeViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 23/06/22.
//

import XCTest

class HomeViewUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        app.buttons["HomeTabBar"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*func test_HomeView_OpenProductAndGoBackToHome() {
        app.scrollViews.otherElements["HomeViewPagingView"].buttons["HomeViewProductLastProductAdded"].tap()
        
        let productName = app.staticTexts["ProductViewHomeName"]
        
        XCTAssertTrue(productName.exists)
        
        app.buttons["Left"].tap()
        
        let tabTitle = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(tabTitle.exists)
    }*/
    
    func test_HomeView_SeeAllButton() {
        app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].tap()
        
        let seeAllName = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(seeAllName.exists)
        
        app.buttons["Left"].tap()
        
        let tabTitle = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(tabTitle.exists)
    }
}
