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
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .phone, "Only test for iPhone")
        app.launch()
        app.buttons["HomeTabBar"].tap()
        let homeViewSeeAllButton = app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].waitForExistence(timeout: 10)
        XCTAssertTrue(homeViewSeeAllButton)
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_iPhone_HomeView_LastProductAdded_OpenProductAndGoBackToHome() {
        if (app.staticTexts["HomeViewLastProductText"].waitForExistence(timeout: 2)) {
            app.scrollViews.otherElements.buttons.element(boundBy: 0).tap()
            //app.buttons["doc.badge.gearshape"].tap()
            
            let productName = app.staticTexts["ProductViewHomeName"]
            
            XCTAssertTrue(productName.exists)
            
            //It shouldn't exist a button before
            app.buttons.firstMatch.tap()
            let tabTitle = app.staticTexts["SelectedTabTitleName"]
            
            XCTAssertTrue(tabTitle.exists)
        }
    }
    
    func test_iPhone_HomeView_SeeAllButton_CheckThatWeReachSeeAllViewAndReturnBack() {
        app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].tap()
        
        let seeAllName = app.staticTexts["SeeAllViewTitle"].waitForExistence(timeout: 10)
        
        XCTAssertTrue(seeAllName)
        
        //It shouldn't exist a button before
        app.buttons.firstMatch.tap()
        
        let tabTitle = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPhone_HomeView_SeeAllButton_CheckThatTheTitlesAreTheSame() {
        let mostTracked = app.staticTexts["HomeViewMostTrackedText"]
        let mostTrackedText = mostTracked.label
        
        XCTAssertTrue(mostTracked.exists)
        
        app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].tap()
        
        let seeAllName = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(seeAllName.exists)
        
        XCTAssertEqual(seeAllName.label.lowercased(), mostTrackedText.lowercased())
    }
    
    func test_iPhone_HomeView_ProductButton_AccessProductAndGoBack() {
        app.scrollViews.buttons["HomeViewMostrTrackedButton0"].tap()
        
        let product = app.staticTexts["ProductViewHomeName"]
        
        XCTAssertTrue(product.exists)
        
        app.buttons.firstMatch.tap()
        
        let tabTitle = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPhone_HomeView_LastAddedProductButton_SwipeProducts() {
        if (app.staticTexts["HomeViewLastProductText"].waitForExistence(timeout: 2)) {
            let product = app.scrollViews.buttons.element(boundBy: 0)
            
            let topOffset = CGVector(dx: 0.95, dy: 0.5)
            let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

            let cellFarRightCoordinate = product.coordinate(withNormalizedOffset: topOffset)
            let cellFarLeftCoordinate = product.coordinate(withNormalizedOffset: bottomOffset)
            
            // drag from right to left to delete
            cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
            
            sleep(5)
            
            XCTAssertFalse(product.isHittable)
            
            let productNew = app.scrollViews.buttons.element(boundBy: 1)
            XCTAssertTrue(productNew.isHittable)
        }
    }
    
    func test_iPhone_HomeView_MostTrackedProductButton_SwipeProducts() {
        let product = app.scrollViews.buttons["HomeViewMostrTrackedButton0"]
        
        let topOffset = CGVector(dx: 0.95, dy: 0.5)
        let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

        let cellFarRightCoordinate = product.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = product.coordinate(withNormalizedOffset: bottomOffset)
        
        // drag from right to left to delete
        cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
        
        sleep(5)
        
        XCTAssertFalse(product.isHittable)
        
        let productNew = app.scrollViews.buttons["HomeViewMostrTrackedButton2"]
        XCTAssertTrue(productNew.exists)
    }
}
