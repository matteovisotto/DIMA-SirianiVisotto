//
//  LoginViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 24/06/22.
//

import XCTest

class LoginViewUITest: XCTestCase {

    let app = XCUIApplication()
    var userIsNotLogged = true
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .phone, "Only test for iPhone")
        app.launch()
        app.buttons["TrackingTabBar"].tap()
        if (!app.buttons["TrackedViewLoginButton"].waitForExistence(timeout: 2)) {
            userIsNotLogged = false
        } else {
            app.buttons["TrackedViewLoginButton"].tap()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPhone_LoginView_RegisterButton_AccessRegisterView() {
        if (userIsNotLogged) {
            app.buttons["LoginViewRegisterButton"].tap()
            let registerText = app.staticTexts["RegisterViewRegisterText"]
            
            XCTAssertTrue(registerText.exists)
            
            app.buttons.firstMatch.tap()
            
            let loginText = app.staticTexts["LoginViewLoginText"]
            XCTAssertTrue(loginText.exists)
        }
    }
    
    func test_iPhone_LoginView_LoginButton_EmailInvalidAndTheButtonIsDisabled() {
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
    
    func test_iPhone_LoginView_LoginButton_PasswordNotInsertedAndTheButtonIsDisabled() {
        if (userIsNotLogged) {
            let email = app.textFields["LoginViewEmailTextField"]
            
            email.tap()
            
            email.typeText("apple@email.com\n")
            
            let loginButton = app.buttons["LoginViewLoginButton"]
            
            XCTAssertFalse(loginButton.isEnabled)
        }
    }
    
    func test_iPhone_LoginView_LoginButton_ButtonIsEnabled() {
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
