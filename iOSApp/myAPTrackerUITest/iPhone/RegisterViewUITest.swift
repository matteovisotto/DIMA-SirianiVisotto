//
//  RegisterViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 24/06/22.
//

import XCTest

class RegisterViewUITest: XCTestCase {

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
            app.buttons["LoginViewRegisterButton"].tap()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPhone_RegisterView_RegisterButton_ButtonIsEnable() {
        if (userIsNotLogged) {
            let registerName = app.textFields["RegisterViewNameTextField"]
            XCTAssertTrue(registerName.exists)
            
            registerName.tap()
            
            registerName.typeText("Name\n")
            
            let registerSurname = app.textFields["RegisterViewSurnameTextField"]
            
            XCTAssertTrue(registerSurname.exists)
            
            registerSurname.tap()
            
            registerSurname.typeText("Surname\n")

            let registerEmail = app.textFields["RegisterViewEmailTextField"]
            
            XCTAssertTrue(registerEmail.exists)
            
            registerEmail.tap()
            
            registerEmail.typeText("apple@email.com\n")
            
            let registerPassword = app.secureTextFields["RegisterViewPasswordTextField"]
            
            XCTAssertTrue(registerPassword.exists)
            
            registerPassword.tap()
            
            registerPassword.typeText("pass\n")
            
            let registerPasswordConf = app.secureTextFields["RegisterViewPasswordConfTextField"]
            
            XCTAssertTrue(registerPasswordConf.exists)
            
            registerPasswordConf.tap()
            
            registerPasswordConf.typeText("pass\n")
            
            let registerToggle = app.switches["RegisterViewToggle"]
            
            XCTAssertTrue(registerToggle.exists)
            
            registerToggle.tap()
            
            let registerButton = app.buttons["RegisterViewRegisterButton"]
            XCTAssertTrue(registerButton.isEnabled)
        }
    }
    
    func test_iPhone_RegisterView_RegisterButton_NoNameInsertedButtonDisabled() {
        if (userIsNotLogged) {
            let registerName = app.textFields["RegisterViewNameTextField"]
            XCTAssertTrue(registerName.exists)
            
            registerName.tap()
            
            let registerSurname = app.textFields["RegisterViewSurnameTextField"]
            
            XCTAssertTrue(registerSurname.exists)
            
            registerSurname.tap()
            
            registerSurname.typeText("Surname\n")
            
            let registerEmail = app.textFields["RegisterViewEmailTextField"]
            
            XCTAssertTrue(registerEmail.exists)
            
            registerEmail.tap()
            
            registerEmail.typeText("apple@email.com\n")
            
            let registerPassword = app.secureTextFields["RegisterViewPasswordTextField"]
            
            XCTAssertTrue(registerPassword.exists)
            
            registerPassword.tap()
            
            registerPassword.typeText("pass\n")
            
            let registerPasswordConf = app.secureTextFields["RegisterViewPasswordConfTextField"]
            
            XCTAssertTrue(registerPasswordConf.exists)
            
            registerPasswordConf.tap()
            
            registerPasswordConf.typeText("pass\n")
            
            let registerToggle = app.switches["RegisterViewToggle"]
            
            XCTAssertTrue(registerToggle.exists)
            
            registerToggle.tap()
            
            let registerButton = app.buttons["RegisterViewRegisterButton"]
            XCTAssertFalse(registerButton.isEnabled)
        }
    }
    
    func test_iPhone_RegisterView_RegisterButton_NoSurnameInsertedButtonDisabled() {
        if (userIsNotLogged) {
            let registerName = app.textFields["RegisterViewNameTextField"]
            XCTAssertTrue(registerName.exists)
            
            registerName.tap()
            
            registerName.typeText("Name\n")
            
            let registerSurname = app.textFields["RegisterViewSurnameTextField"]
            
            XCTAssertTrue(registerSurname.exists)
            
            let registerEmail = app.textFields["RegisterViewEmailTextField"]
            
            XCTAssertTrue(registerEmail.exists)
            
            registerEmail.tap()
            
            registerEmail.typeText("apple@email.com\n")
            
            let registerPassword = app.secureTextFields["RegisterViewPasswordTextField"]
            
            XCTAssertTrue(registerPassword.exists)
            
            registerPassword.tap()
            
            registerPassword.typeText("pass\n")
            
            let registerPasswordConf = app.secureTextFields["RegisterViewPasswordConfTextField"]
            
            XCTAssertTrue(registerPasswordConf.exists)
            
            registerPasswordConf.tap()
            
            registerPasswordConf.typeText("pass\n")
            
            let registerToggle = app.switches["RegisterViewToggle"]
            
            XCTAssertTrue(registerToggle.exists)
            
            registerToggle.tap()
            
            let registerButton = app.buttons["RegisterViewRegisterButton"]
            XCTAssertFalse(registerButton.isEnabled)
        }
    }
    
    func test_iPhone_RegisterView_RegisterButton_InvalidEmailInsertedButtonDisabled() {
        if (userIsNotLogged) {
            let registerName = app.textFields["RegisterViewNameTextField"]
            XCTAssertTrue(registerName.exists)
            
            registerName.tap()
            
            registerName.typeText("Name\n")
            
            let registerSurname = app.textFields["RegisterViewSurnameTextField"]
            
            XCTAssertTrue(registerSurname.exists)
            
            registerSurname.tap()
            
            registerSurname.typeText("Surname\n")
            
            let registerEmail = app.textFields["RegisterViewEmailTextField"]
            
            XCTAssertTrue(registerEmail.exists)
            
            registerEmail.tap()
            
            registerEmail.typeText("appleemail.com\n")
            
            let registerPassword = app.secureTextFields["RegisterViewPasswordTextField"]
            
            XCTAssertTrue(registerPassword.exists)
            
            registerPassword.tap()
            
            registerPassword.typeText("pass\n")
            
            let registerPasswordConf = app.secureTextFields["RegisterViewPasswordConfTextField"]
            
            XCTAssertTrue(registerPasswordConf.exists)
            
            registerPasswordConf.tap()
            
            registerPasswordConf.typeText("pass\n")
            
            let registerToggle = app.switches["RegisterViewToggle"]
            
            XCTAssertTrue(registerToggle.exists)
            
            registerToggle.tap()
            
            let registerButton = app.buttons["RegisterViewRegisterButton"]
            XCTAssertFalse(registerButton.isEnabled)
        }
    }
    
    func test_iPhone_RegisterView_RegisterButton_PasswordsNotMatchingInsertedButtonDisabled() {
        if (userIsNotLogged) {
            let registerName = app.textFields["RegisterViewNameTextField"]
            XCTAssertTrue(registerName.exists)
            
            registerName.tap()
            
            registerName.typeText("Name\n")
            
            let registerSurname = app.textFields["RegisterViewSurnameTextField"]
            
            XCTAssertTrue(registerSurname.exists)
            
            registerSurname.tap()
            
            registerSurname.typeText("Surname\n")
            
            let registerEmail = app.textFields["RegisterViewEmailTextField"]
            
            XCTAssertTrue(registerEmail.exists)
            
            registerEmail.tap()
            
            registerEmail.typeText("apple@email.com\n")
            
            let registerPassword = app.secureTextFields["RegisterViewPasswordTextField"]
            
            XCTAssertTrue(registerPassword.exists)
            
            registerPassword.tap()
            
            registerPassword.typeText("pass\n")
            
            let registerPasswordConf = app.secureTextFields["RegisterViewPasswordConfTextField"]
            
            XCTAssertTrue(registerPasswordConf.exists)
            
            registerPasswordConf.tap()
            
            registerPasswordConf.typeText("pass2\n")
            
            let registerToggle = app.switches["RegisterViewToggle"]
            
            XCTAssertTrue(registerToggle.exists)
            
            registerToggle.tap()
            
            let registerButton = app.buttons["RegisterViewRegisterButton"]
            XCTAssertFalse(registerButton.isEnabled)
        }
    }
    
    func test_iPhone_RegisterView_RegisterButton_TermsNotToggledButtonDisabled() {
        if (userIsNotLogged) {
            let registerName = app.textFields["RegisterViewNameTextField"]
            XCTAssertTrue(registerName.exists)
            
            registerName.tap()
            
            registerName.typeText("Name\n")
            
            let registerSurname = app.textFields["RegisterViewSurnameTextField"]
            
            XCTAssertTrue(registerSurname.exists)
            
            registerSurname.tap()
            
            registerSurname.typeText("Surname\n")
            
            let registerEmail = app.textFields["RegisterViewEmailTextField"]
            
            XCTAssertTrue(registerEmail.exists)
            
            registerEmail.tap()
            
            registerEmail.typeText("apple@email.com\n")
            
            let registerPassword = app.secureTextFields["RegisterViewPasswordTextField"]
            
            XCTAssertTrue(registerPassword.exists)
            
            registerPassword.tap()
            
            registerPassword.typeText("pass\n")
            
            let registerPasswordConf = app.secureTextFields["RegisterViewPasswordConfTextField"]
            
            XCTAssertTrue(registerPasswordConf.exists)
            
            registerPasswordConf.tap()
            
            registerPasswordConf.typeText("pass\n")
            
            let registerToggle = app.switches["RegisterViewToggle"]
            
            XCTAssertTrue(registerToggle.exists)
            
            let registerButton = app.buttons["RegisterViewRegisterButton"]
            XCTAssertFalse(registerButton.isEnabled)
        }
    }
}
