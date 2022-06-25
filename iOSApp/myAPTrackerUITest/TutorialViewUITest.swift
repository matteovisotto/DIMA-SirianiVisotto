//
//  TutorialViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 24/06/22.
//

import XCTest

class TutorialViewUITest: XCTestCase {

    let app = XCUIApplication()
    var userHasAlreadyDoneTheTutorial = false
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        if (app.staticTexts["HomeViewMostTrackedText"].exists) {
            userHasAlreadyDoneTheTutorial = true
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TutorialView_ChangePageButton_UserChangePage() {
        if (!userHasAlreadyDoneTheTutorial) {
            app.images["Right"].tap()
            
            sleep(10)
            
            app.images["Right"].tap()
            
            sleep(10)
            
            let next = app.images["Right"]
            let done = app.otherElements.images.firstMatch
            
            XCTAssertFalse(next.exists)
            XCTAssertTrue(done.exists)
        }
    }
}
