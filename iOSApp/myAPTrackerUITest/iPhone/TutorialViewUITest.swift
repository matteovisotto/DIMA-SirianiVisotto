//
//  TutorialViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 24/06/22.
//

import XCTest

class TutorialViewUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .phone, "Only test for iPhone")
        app.launchArguments = ["-UITest_TutorialToSee"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPhone_TutorialView_ChangePageButton_UserChangePageAndEndsTutorial() {
        app.images.allElementsBoundByIndex.last?.tap()

        sleep(10)
        
        app.images.allElementsBoundByIndex.last?.tap()

        sleep(10)
        
        let next = app.images["Right"]
        let done = app.otherElements.images.firstMatch
        
        XCTAssertFalse(next.exists)
        XCTAssertTrue(done.exists)
        
        app.buttons["TutorialViewSkipButton"].tap()
        
        sleep(10)
        
        XCTAssertTrue(app.staticTexts["HomeViewMostTrackedText"].exists)
    }
    
    func test_iPhone_TutorialView_SkipButton_UserEndsTutorialThroughSkip() {
        app.buttons["TutorialViewSkipButton"].tap()
        
        sleep(10)
        
        XCTAssertTrue(app.staticTexts["HomeViewMostTrackedText"].exists)
    }
}
