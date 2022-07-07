//
//  TrackedViewiPadUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 02/07/22.
//

import XCTest

class TrackedViewiPadUITest: XCTestCase {

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
        
        app.otherElements.buttons["iPadMainButton1"].tap()
        
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

    func test_iPad_TrackedView_TextField_NoResult() {
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            let textField = app.textFields["TrackedViewSearchTextField"]
            
            textField.tap()
            
            textField.typeText("Aaaaa\n")
            
            let noResult = app.staticTexts["TrackedViewNoResult"]
            
            XCTAssertTrue(noResult.exists)
        }
    }
    
    func test_iPad_TrackedView_TextField_Result() {
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            let textField = app.textFields["TrackedViewSearchTextField"]
            
            textField.tap()
            
            textField.typeText("Apple\n")
            
            let noResult = app.staticTexts["TrackedViewNoResult"]
            
            XCTAssertFalse(noResult.exists)
        }
    }
    
    func test_iPad_TrackedView_ProductButton_AccessAPrdouct() {
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            if (!app.staticTexts["TrackedViewNoResult"].exists) {
                app.scrollViews.otherElements.buttons.firstMatch.tap()
                let productName = app.staticTexts["ProductViewiPadProductPrice"]
                XCTAssertTrue(productName.exists)
            } else {
                XCTAssertTrue(app.staticTexts["TrackedViewNoResult"].exists)
            }
        }
    }
    
    func test_iPad_TrackedView_ProductButton_AccessAPrdouctAndGoBack() {
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            if (!app.staticTexts["TrackedViewNoResult"].exists) {
                app.scrollViews.otherElements.buttons.firstMatch.tap()
                let productName = app.staticTexts["ProductViewiPadProductPrice"]
                XCTAssertTrue(productName.exists)
                
                //It shouldn't exist a button before
                if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                    app.buttons.firstMatch.tap()
                } else {
                    app.buttons.firstMatch.tap()
                    app.buttons.firstMatch.tap()
                }
                
                let textField = app.textFields["TrackedViewSearchTextField"]
                XCTAssertTrue(textField.exists)
            } else {
                XCTAssertTrue(app.staticTexts["TrackedViewNoResult"].exists)
            }
        }
    }
    
    func test_iPad_TrackedView_LoginButton_AccessLogin() {
        if (app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            app.buttons["TrackedViewLoginButton"].tap()
            
            let loginText = app.staticTexts["LoginViewLoginText"]
            
            XCTAssertTrue(loginText.exists)
            
            let topOffset = CGVector(dx: 0.5, dy: 1.1)

            let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)
            
            cellFarRightCoordinate.press(forDuration: 1)
            
            let loginButtonNew = app.buttons["TrackedViewLoginButton"]
            XCTAssertTrue(loginButtonNew.exists)
        }
    }
}
