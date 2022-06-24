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
        if (app.staticTexts["HomeViewLastProductText"].exists) {
            app.scrollViews.otherElements["HomeViewPagingView"].buttons["HomeViewProductLastProductAdded"].tap()
            
            let productName = app.staticTexts["ProductViewHomeName"]
            
            XCTAssertTrue(productName.exists)
            
            //It shouldn't exist a button before
            app.buttons.firstMatch.tap()
            let tabTitle = app.staticTexts["SelectedTabTitleName"]
            
            XCTAssertTrue(tabTitle.exists)
        }
    }*/
    
    func test_HomeView_SeeAllButton_CheckThatWeReachSeeAllViewAndReturnBack() {
        app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].tap()
        
        let seeAllName = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(seeAllName.exists)
        
        //It shouldn't exist a button before
        app.buttons.firstMatch.tap()
        
        let tabTitle = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(tabTitle.exists)
    }
    
    func test_HomeView_SeeAllButton_CheckThatTheTitlesAreTheSame() {
        let mostTracked = app.staticTexts["HomeViewMostTrackedText"]
        let mostTrackedText = mostTracked.label
        
        XCTAssertTrue(mostTracked.exists)
        
        app.scrollViews.otherElements.buttons["HomeViewSeeAllButton"].tap()
        
        let seeAllName = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(seeAllName.exists)
        
        XCTAssertEqual(seeAllName.label.lowercased(), mostTrackedText.lowercased())
    }
    
    func test_HomeView_ProductButton_AccessProductAndGoBack() {
        app.scrollViews.otherElements.scrollViews.otherElements.buttons.element(boundBy: 0).tap()
        
        let product = app.staticTexts["ProductViewHomeName"]
        
        XCTAssertTrue(product.exists)
        
        app.buttons.firstMatch.tap()
        
        let tabTitle = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(tabTitle.exists)
    }
    
    /*func test_HomeView_LastAddedProductButton_AccessProductAndGoBack() {
        app.scrollViews.buttons.element(boundBy: 0).tap()
        
        let product = app.staticTexts["ProductViewHomeName"]
        
        XCTAssertTrue(product.exists)
        
        app.buttons.firstMatch.tap()
        
        let tabTitle = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(tabTitle.exists)
    }*/
}
