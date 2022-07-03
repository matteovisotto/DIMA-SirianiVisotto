//
//  TrackedViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 23/06/22.
//

import XCTest

class TrackedViewUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .phone, "Only test for iPhone")
        app.launch()
        app.buttons["TrackingTabBar"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPhone_TrackedView_TextField_NoResult() {
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            let textField = app.textFields["TrackedViewSearchTextField"]
            
            textField.tap()
            
            textField.typeText("Aaaaa\n")
            
            let noResult = app.staticTexts["TrackedViewNoResult"]
            
            XCTAssertTrue(noResult.exists)
        }
    }
    
    func test_iPhone_TrackedView_TextField_Result() {
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            let textField = app.textFields["TrackedViewSearchTextField"]
            
            textField.tap()
            
            textField.typeText("Apple\n")
            
            let noResult = app.staticTexts["TrackedViewNoResult"]
            
            XCTAssertFalse(noResult.exists)
        }
    }
    
    func test_iPhone_TrackedView_ProductButton_AccessAPrdouct() {
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            if (!app.staticTexts["TrackedViewNoResult"].exists) {
                app.scrollViews.otherElements.buttons.firstMatch.tap()
                let productName = app.staticTexts["ProductViewHomeName"]
                XCTAssertTrue(productName.exists)
            } else {
                XCTAssertTrue(app.staticTexts["TrackedViewNoResult"].exists)
            }
        }
    }
    
    func test_iPhone_TrackedView_ProductButton_AccessAPrdouctAndGoBack() {
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            if (!app.staticTexts["TrackedViewNoResult"].exists) {
                app.scrollViews.otherElements.buttons.firstMatch.tap()
                let productName = app.staticTexts["ProductViewHomeName"]
                XCTAssertTrue(productName.exists)
                
                //It shouldn't exist a button before
                app.buttons.firstMatch.tap()
                
                let textField = app.textFields["TrackedViewSearchTextField"]
                XCTAssertTrue(textField.exists)
            } else {
                XCTAssertTrue(app.staticTexts["TrackedViewNoResult"].exists)
            }
        }
    }
    
    func test_iPhone_TrackedView_LoginButton_AccessLogin() {
        if (app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            app.buttons["TrackedViewLoginButton"].tap()
            
            let loginText = app.staticTexts["LoginViewLoginText"]
            
            XCTAssertTrue(loginText.exists)
            
            //It shouldn't exist a button before
            app.buttons.firstMatch.tap()
            
            let loginButtonNew = app.buttons["TrackedViewLoginButton"]
            XCTAssertTrue(loginButtonNew.exists)
        }
    }
}
