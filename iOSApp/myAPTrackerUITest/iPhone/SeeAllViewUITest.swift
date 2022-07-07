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
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .phone, "Only test for iPhone")
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

    func test_iPhone_SeeAllView_OpenCategories () {
        let seeAllButtonCategories = app.buttons["SeeAllViewCategoriesButton"]
        
        XCTAssertTrue(seeAllButtonCategories.exists)
        
        app.buttons["SeeAllViewCategoriesButton"].tap()
        
        let categories = app.staticTexts["FilterViewSelectMoreCategories"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(categories)
    }
    
    func test_iPhone_SeeAllView_FilterCategoriesButton_OpenCategoriesAndCloseIt() {
        app.buttons["SeeAllViewCategoriesButton"].tap()
        
        let categories = app.staticTexts["FilterViewSelectMoreCategories"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(categories)
        
        app.buttons["FilterViewCloseCategories"].tap()
        XCTAssertTrue(app.buttons["SeeAllViewCategoriesButton"].waitForExistence(timeout: 5))
        let seeAllName = app.buttons["SeeAllViewCategoriesButton"]
        
        XCTAssertTrue(seeAllName.isHittable)
    }
    
    func test_iPhone_SeeAllView_Categories_ChooseCategories() {
        app.buttons["SeeAllViewCategoriesButton"].tap()
        
        let categories = app.staticTexts["FilterViewSelectMoreCategories"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(categories)
        
        let category = app.tables.buttons.element(boundBy: 1)
        category.tap()
        
        let categoryText = category.label
        
        app.buttons["FilterViewCloseCategories"].tap()
        
        sleep(2)

        let seeAllCategory = app.staticTexts["SeeAllViewCategoryFilterText"]
                        
        XCTAssertTrue(seeAllCategory.label != "")
        
        XCTAssertTrue(seeAllCategory.label.lowercased() == categoryText.lowercased())
    }
    
    func test_iPhone_SeeAllView_CategoriesButton_CloseCategories() {
        app.buttons["SeeAllViewCategoriesButton"].tap()
        
        let categories = app.staticTexts["FilterViewSelectMoreCategories"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(categories)
        
        let topOffset = CGVector(dx: 0.5, dy: 0.95)
        let bottomOffset = CGVector(dx: 0.5, dy: 0.15)

        let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = app.coordinate(withNormalizedOffset: bottomOffset)

        // drag from right to left to delete
        cellFarLeftCoordinate.press(forDuration: 0.1, thenDragTo: cellFarRightCoordinate)
                
        sleep(5)
        
        let seeAllName = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(seeAllName.isHittable)
    }
    
    func test_iPhone_SeeAllView_FilterCategoriesButton_OpenProductAndCloseIt() {
        app.tables.buttons.element(boundBy: 0).tap()
        
        let product = app.staticTexts["ProductViewHomeName"]
        
        XCTAssertTrue(product.exists)
        
        app.buttons.firstMatch.tap()
        
        let seeAllName = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(seeAllName.exists)
    }
}
