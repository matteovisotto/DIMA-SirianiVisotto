//
//  ExploreViewiPadUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 02/07/22.
//

import XCTest

class ExploreViewiPadUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .pad, "Only test for iPad")
        app.launch()
        
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        }
        
        app.otherElements.buttons["iPadMainButton2"].tap()
        
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            let topOffset = CGVector(dx: 0.95, dy: 0.5)
            let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

            let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)
            let cellFarLeftCoordinate = app.coordinate(withNormalizedOffset: bottomOffset)
            
            // drag from right to left to delete
            cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
        }
        
        sleep(5)
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPad_ExploreView_FirstSeeAllButton_CheckWorking() {
        app.buttons["ExploreViewFirstSeeAll"].tap()
        
        let titleSeeAllView = app.buttons["SeeAllViewiPadItem0"]
        sleep(5)
        XCTAssertTrue(titleSeeAllView.exists)
        
        //It shouldn't exist a button before
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let seeAllName = app.staticTexts["ExploreViewFirstTitle"]
        XCTAssertTrue(seeAllName.exists)
    }
    
    func test_iPad_ExploreView_FirstSeeAllCategories_AccessProductsAndGoBack() {
        app.scrollViews.buttons["ExploreViewFirstProduct0"].tap()
        
        let product = app.staticTexts["ProductViewiPadProductPrice"]
        
        XCTAssertTrue(product.exists)
        
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let tabTitle = app.staticTexts["ExploreViewFirstTitle"]

        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPad_ExploreView_FirstSeeAllCategories_SwipeProducts() {
        let product = app.scrollViews.buttons["ExploreViewFirstProduct0"]
        XCTAssertTrue(product.isHittable)
        
        let product2 = app.scrollViews.buttons["ExploreViewFirstProduct6"]
        XCTAssertFalse(product2.isHittable)
        
        let topOffset = CGVector(dx: 1.95, dy: 0.5)
        let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

        let cellFarRightCoordinate = product.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = product.coordinate(withNormalizedOffset: bottomOffset)
        
        // drag from right to left to delete
        cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
        
        sleep(5)
        
        let productNewHit = app.scrollViews.buttons["ExploreViewFirstProduct6"]
        
        sleep(2)
        XCTAssertFalse(product.isHittable)
        XCTAssertTrue(productNewHit.isHittable)
    }
    
    func test_iPad_ExploreView_SecondSeeAllButton_CheckWorking() {
        app.buttons["ExploreViewSecondSeeAll"].tap()
        
        let titleSeeAllView = app.buttons["SeeAllViewiPadItem0"]
        
        XCTAssertTrue(titleSeeAllView.exists)
        
        //It shouldn't exist a button before
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let seeAllName = app.staticTexts["ExploreViewSecondTitle"]
        XCTAssertTrue(seeAllName.exists)
    }
    
    func test_iPad_ExploreView_SecondSeeAllCategories_AccessProductsAndGoBack() {
        app.scrollViews.buttons["ExploreViewSecondProduct0"].tap()
        
        let product = app.staticTexts["ProductViewiPadProductPrice"]
        
        XCTAssertTrue(product.exists)
        
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let tabTitle = app.staticTexts["ExploreViewSecondTitle"]

        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPad_ExploreView_SecondSeeAllCategories_SwipeProducts() {
        let product = app.scrollViews.buttons["ExploreViewSecondProduct0"]
        XCTAssertTrue(product.isHittable)
        
        let product2 = app.scrollViews.buttons["ExploreViewSecondProduct6"]
        XCTAssertFalse(product2.isHittable)
        
        let topOffset = CGVector(dx: 1.95, dy: 0.5)
        let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

        let cellFarRightCoordinate = product.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = product.coordinate(withNormalizedOffset: bottomOffset)
        
        // drag from right to left to delete
        cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
        
        sleep(5)
        
        let productNewHit = app.scrollViews.buttons["ExploreViewSecondProduct6"]
        
        XCTAssertFalse(product.isHittable)
        XCTAssertTrue(productNewHit.isHittable)
    }
    
    func test_iPad_ExploreView_ThirdSeeAllButton_CheckWorking() {
        app.buttons["ExploreViewThirdSeeAll"].tap()
        
        let titleSeeAllView = app.buttons["SeeAllViewiPadItem0"]
        sleep(10)
        XCTAssertTrue(titleSeeAllView.exists)
        
        //It shouldn't exist a button before
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let seeAllName = app.staticTexts["ExploreViewThirdTitle"]
        XCTAssertTrue(seeAllName.exists)
    }
    
    func test_iPad_ExploreView_ThirdSeeAllCategories_AccessProductsAndGoBack() {
        app.scrollViews.buttons["ExploreViewThirdProduct0"].tap()
        
        let product = app.staticTexts["ProductViewiPadProductPrice"]
        
        XCTAssertTrue(product.exists)
        
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let tabTitle = app.staticTexts["ExploreViewThirdTitle"]

        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPad_ExploreView_ThirdSeeAllCategories_SwipeProducts() {
        let topOffset = CGVector(dx: 0.5, dy: 0.5)
        let bottomOffset = CGVector(dx: 0.5, dy: 0.15)

        let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = app.coordinate(withNormalizedOffset: bottomOffset)

        // drag from right to left to delete
        cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
                
        sleep(5)
        
        let product = app.scrollViews.buttons["ExploreViewThirdProduct0"]
        XCTAssertTrue(product.isHittable)
        
        let product2 = app.scrollViews.buttons["ExploreViewThirdProduct6"]
        XCTAssertFalse(product2.isHittable)
        
        let topOffset2 = CGVector(dx: 1.95, dy: 0.5)
        let bottomOffset2 = CGVector(dx: 0.05, dy: 0.5)

        let cellFarRightCoordinate2 = product.coordinate(withNormalizedOffset: topOffset2)
        let cellFarLeftCoordinate2 = product.coordinate(withNormalizedOffset: bottomOffset2)
        
        // drag from right to left to delete
        cellFarRightCoordinate2.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate2)
        
        sleep(5)
        
        let productNewHit = app.scrollViews.buttons["ExploreViewThirdProduct6"]
        
        XCTAssertFalse(product.isHittable)
        XCTAssertTrue(productNewHit.isHittable)
    }
}
