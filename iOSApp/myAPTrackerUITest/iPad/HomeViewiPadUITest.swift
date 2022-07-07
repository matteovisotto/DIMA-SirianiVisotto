//
//  HomeViewiPadUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 02/07/22.
//

import XCTest

class HomeViewiPadUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .pad, "Only test for iPad")
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPad_HomeView_LastProductAdded_OpenProductAndGoBackToHome() {
        if (app.staticTexts["HomeViewLastProductText"].waitForExistence(timeout: 5)) {
            app.scrollViews.buttons.element(boundBy: 0).tap()
            
            let productName = app.staticTexts["ProductViewiPadProductPrice"]
            
            XCTAssertTrue(productName.exists)
            
            //It shouldn't exist a button before
            if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                app.buttons.firstMatch.tap()
            } else {
                app.buttons.firstMatch.tap()
                app.buttons.firstMatch.tap()
            }
            
            let tabTitle = app.staticTexts["HomeViewLastProductText"]
            
            XCTAssertTrue(tabTitle.exists)
        }
    }
    
    func test_iPad_HomeView_MostTracked_OpenProductAndGoBackToHome() {
        app.scrollViews.otherElements.buttons["HomeViewMostrTrackedButton0"].tap()
        
        let productName = app.staticTexts["ProductViewiPadProductPrice"]
        
        XCTAssertTrue(productName.exists)
        
        //It shouldn't exist a button before
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let tabTitle = app.staticTexts["HomeViewMostTrackedText"]
        
        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPad_HomeView_Categories_AccessCategoryAndGoBack() {
        app.scrollViews.buttons["HomeViewCategoryButton0"].tap()
        
        let product = app.staticTexts["SeeAllViewCategoryFilterText"]
        
        XCTAssertTrue(product.exists)
        
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let tabTitle = app.staticTexts["HomeViewMostTrackedText"]
        
        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPad_HomeView_SeeAllButton_CheckThatWeReachSeeAllViewAndReturnBack() {
        app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].tap()
        
        let seeAllName = app.buttons["SeeAllViewiPadItem0"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(seeAllName)
        
        //It shouldn't exist a button before
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let tabTitle = app.staticTexts["HomeViewMostTrackedText"]
        
        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPad_HomeView_ProductButton_AccessProductAndGoBack() {
        app.scrollViews.buttons["HomeViewMostrTrackedButton0"].tap()
        
        let product = app.staticTexts["ProductViewiPadProductPrice"]
        
        XCTAssertTrue(product.exists)
        
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        } else {
            app.buttons.firstMatch.tap()
            app.buttons.firstMatch.tap()
        }
        
        let tabTitle = app.staticTexts["HomeViewMostTrackedText"]
        
        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_iPad_HomeView_LastAddedProductButton_SwipeProducts() {
        if (app.staticTexts["HomeViewLastProductText"].waitForExistence(timeout: 5)) {
            let product = app.scrollViews.buttons.element(boundBy: 0)
            
            let topOffset = CGVector(dx: 1.95, dy: 0.5)
            let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

            let cellFarRightCoordinate = product.coordinate(withNormalizedOffset: topOffset)
            let cellFarLeftCoordinate = product.coordinate(withNormalizedOffset: bottomOffset)
            
            // drag from right to left to delete
            cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
            
            sleep(5)
            
            XCTAssertFalse(product.isHittable)
            
            let productNew = app.scrollViews.buttons.element(boundBy: 2)
            XCTAssertTrue(productNew.isHittable)
            let productNew2 = app.scrollViews.buttons.element(boundBy: 3)
            XCTAssertTrue(productNew2.isHittable)
        }
    }
    
    func test_iPad_HomeView_MostTrackedProductButton_SwipeProducts() {
        let product = app.scrollViews.otherElements.buttons["HomeViewMostrTrackedButton0"]
        
        let topOffset = CGVector(dx: 0.95, dy: 0.5)
        let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

        let cellFarRightCoordinate = product.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = product.coordinate(withNormalizedOffset: bottomOffset)
        
        // drag from right to left to delete
        cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
        
        sleep(5)
        
        XCTAssertFalse(product.isHittable)
        
        let productNew = app.scrollViews.otherElements.buttons["HomeViewMostrTrackedButton6"]
        XCTAssertTrue(productNew.isHittable)
    }
    
    func test_iPad_HomeView_CategoriesButton_SwipeProducts() {
        let category = app.scrollViews.buttons["HomeViewCategoryButton0"]
        
        let topOffset = CGVector(dx: 1.95, dy: 0.5)
        let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

        let cellFarRightCoordinate = category.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = category.coordinate(withNormalizedOffset: bottomOffset)
        
        // drag from right to left to delete
        cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
        
        sleep(5)
        
        XCTAssertFalse(category.isHittable)
        
        let categoryNew = app.scrollViews.buttons["HomeViewCategoryButton6"]
        XCTAssertTrue(categoryNew.exists)
    }
    
    func test_iPad_HomeView_Categories_AccessCategoriesAndCheckSameTitle() {
        let productTitle = app.scrollViews.buttons["HomeViewCategoryButton0"].label
        
        app.scrollViews.buttons["HomeViewCategoryButton0"].tap()
        
        let product = app.staticTexts["SeeAllViewCategoryFilterText"]
        
        XCTAssertTrue(product.exists)
        
        XCTAssertEqual(productTitle.lowercased(), app.staticTexts["SeeAllViewCategoryFilterText"].label.lowercased())
    }
}
