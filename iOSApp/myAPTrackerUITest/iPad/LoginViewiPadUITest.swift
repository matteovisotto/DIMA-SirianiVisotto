//
//  LoginViewiPadUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 02/07/22.
//

import XCTest

class LoginViewiPadUITest: XCTestCase {

    let app = XCUIApplication()
    var userIsNotLogged = true
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .pad, "Only test for iPad")
        app.launch()
        
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        }
        
        app.otherElements.buttons["iPadMainButton1"].tap()
        let topOffset = CGVector(dx: 0.95, dy: 0.5)
        let bottomOffset = CGVector(dx: 0.05, dy: 0.5)

        let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = app.coordinate(withNormalizedOffset: bottomOffset)
        
        // drag from right to left to delete
        cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
        
        sleep(5)
        
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            userIsNotLogged = false
        } else {
            app.buttons["TrackedViewLoginButton"].tap()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPad_LoginView_RegisterButton_AccessRegisterView() {
        if (userIsNotLogged) {
            app.buttons["LoginViewRegisterButton"].tap()
            let registerText = app.staticTexts["RegisterViewRegisterText"]
            
            XCTAssertTrue(registerText.exists)
        }
    }
    
    func test_iPad_LoginView_LoginButton_EmailInvalidAndTheButtonIsDisabled() {
        if (userIsNotLogged) {
            let email = app.textFields["LoginViewEmailTextField"]
            
            email.tap()
            
            email.typeText("apple\n")
            
            let password = app.secureTextFields["LoginViewPasswordTextField"]
            password.tap()
            
            password.typeText("pass\n")
            
            let loginButton = app.buttons["LoginViewLoginButton"]
            
            XCTAssertFalse(loginButton.isEnabled)
        }
    }
    
    func test_iPad_LoginView_LoginButton_PasswordNotInsertedAndTheButtonIsDisabled() {
        if (userIsNotLogged) {
            let email = app.textFields["LoginViewEmailTextField"]
            
            email.tap()
            
            email.typeText("apple@email.com\n")
            
            let loginButton = app.buttons["LoginViewLoginButton"]
            
            XCTAssertFalse(loginButton.isEnabled)
        }
    }
    
    func test_iPad_LoginView_LoginButton_ButtonIsEnabled() {
        if (userIsNotLogged) {
            let email = app.textFields["LoginViewEmailTextField"]
            
            email.tap()
            
            email.typeText("apple@email.com\n")
            
            let password = app.secureTextFields["LoginViewPasswordTextField"]
            password.tap()
            
            password.typeText("pass\n")
            
            let loginButton = app.buttons["LoginViewLoginButton"]
            
            XCTAssertTrue(loginButton.isEnabled)
        }
    }
}
