//
//  ExploreViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 23/06/22.
//

import XCTest

class ExploreViewUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        app.buttons["ExploreTabBar"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ExploreView_FirstSeeAllButton_CheckWorking() {
        app.buttons["ExploreViewFirstSeeAll"].tap()
        
        let titleSeeAllView = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(titleSeeAllView.exists)
        
        //It shouldn't exist a button before
        app.buttons.firstMatch.tap()
        
        let seeAllName = app.staticTexts["ExploreViewFirstTitle"]
        XCTAssertTrue(seeAllName.exists)
    }
    
    func test_ExploreView_FirstSeeAllButton_CheckSameTitle() {
        let seeAllName = app.staticTexts["ExploreViewFirstTitle"]
        let seeAllNameText = seeAllName.label
        
        XCTAssertTrue(seeAllName.exists)
        
        app.buttons["ExploreViewFirstSeeAll"].tap()
        
        let titleSeeAllView = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(titleSeeAllView.exists)
        
        XCTAssertEqual(seeAllNameText.lowercased(), titleSeeAllView.label.lowercased())
    }
    
    func test_ExploreView_SecondSeeAllButton_CheckWorking() {
        app.buttons["ExploreViewSecondSeeAll"].tap()
        
        let titleSeeAllView = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(titleSeeAllView.exists)
        
        //It shouldn't exist a button before
        app.buttons.firstMatch.tap()
        
        let seeAllName = app.staticTexts["ExploreViewSecondTitle"]
        XCTAssertTrue(seeAllName.exists)
    }
    
    func test_ExploreView_SecondSeeAllButton_CheckSameTitle() {
        let seeAllName = app.staticTexts["ExploreViewSecondTitle"]
        let seeAllNameText = seeAllName.label
        
        XCTAssertTrue(seeAllName.exists)
        
        app.buttons["ExploreViewSecondSeeAll"].tap()
        
        let titleSeeAllView = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(titleSeeAllView.exists)
        
        XCTAssertEqual(seeAllNameText.lowercased(), titleSeeAllView.label.lowercased())
    }
    
    func test_ExploreView_ThirdSeeAllButton_CheckWorking() {
        app.buttons["ExploreViewThirdSeeAll"].tap()
        
        let titleSeeAllView = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(titleSeeAllView.exists)
        
        //It shouldn't exist a button before
        app.buttons.firstMatch.tap()
        
        let seeAllName = app.staticTexts["ExploreViewThirdTitle"]
        XCTAssertTrue(seeAllName.exists)
    }
    
    func test_ExploreView_ThirdSeeAllButton_CheckSameTitle() {
        let seeAllName = app.staticTexts["ExploreViewThirdTitle"]
        let seeAllNameText = seeAllName.label
        
        XCTAssertTrue(seeAllName.exists)
        
        app.buttons["ExploreViewThirdSeeAll"].tap()
        
        let titleSeeAllView = app.staticTexts["SeeAllViewTitle"]
        
        XCTAssertTrue(titleSeeAllView.exists)
        
        XCTAssertEqual(seeAllNameText.lowercased(), titleSeeAllView.label.lowercased())
    }
}
