//
//  SettingsViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 23/06/22.
//

import XCTest

class SettingsViewUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .phone, "Only test for iPhone")
        app.launch()
        app.buttons["SettingsTabBar"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPhone_SettingsView_UserLoginRegister_UserIsLogged() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            let loginButton = app.tables.buttons["LoginOrCreateAnAccountButton"]
            XCTAssertFalse(loginButton.exists)
        } else {
            let loginButton = app.tables.buttons["LoginOrCreateAnAccountButton"]
            XCTAssertTrue(loginButton.exists)
        }
    }
    
    func test_iPhone_SettingsView_UserLoginRegister_UserIsNotLoggedAndGoToLoginPageAndReturnToPreviousPage() {
        if (app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            let loginButton = app.tables.buttons["LoginOrCreateAnAccountButton"]
            XCTAssertTrue(loginButton.exists)
            
            loginButton.tap()
            
            let loginText = app.staticTexts["LoginViewLoginText"]
            
            XCTAssertTrue(loginText.exists)
            
            //It shouldn't exist a button before
            app.buttons.firstMatch.tap()
            
            let loginButtonNew = app.tables.buttons["LoginOrCreateAnAccountButton"]
            XCTAssertTrue(loginButtonNew.exists)
        }
    }
    
    func test_iPhone_SettingsView_UserProfileInformation_UserShowInfo() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["UserProfileNavigationLink"].tap()
                    
            let profileText = app.scrollViews.otherElements.staticTexts["ProfileText"]
            
            XCTAssertTrue(profileText.exists)
        }
    }
    
    func test_iPhone_SettingsView_UserProfileInformation_UserShowInfoAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["UserProfileNavigationLink"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            
            XCTAssertTrue(elementsQuery.staticTexts["ProfileText"].exists)
            
            app.buttons.firstMatch.tap()
            let settingsText = app.staticTexts["SelectedTabTitleName"]
            
            XCTAssertTrue(settingsText.exists)
        }
    }
    
    func test_iPhone_SettingsView_UserTrackingInformation_UserModifyToNeverTrackingNotificationAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["ProductNotification"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            let neverButton = elementsQuery.segmentedControls.containing(.button, identifier:"NeverSettingsPicker").buttons["NeverSettingsPicker"]
            neverButton.tap()
            
            XCTAssertTrue(neverButton.exists)
            
            elementsQuery.children(matching: .segmentedControl).element(boundBy: 1).buttons["NeverCommentButton"].tap()
            elementsQuery.buttons["ChangeSettingsTrackingButton"].tap()
            app.buttons.firstMatch.tap()

            let settingsText = app.staticTexts["SelectedTabTitleName"]
            
            XCTAssertTrue(settingsText.exists)
        }
    }
    
    func test_iPhone_SettingsView_UserTrackingInformation_UserModifyToAlwaysTrackingNotificationAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["ProductNotification"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            let alwaysButton = elementsQuery.segmentedControls.containing(.button, identifier:"AlwaysSettingsPicker").buttons["AlwaysSettingsPicker"]
            alwaysButton.tap()
            
            XCTAssertTrue(alwaysButton.exists)
            
            elementsQuery.children(matching: .segmentedControl).element(boundBy: 1).buttons["AlwaysCommentButton"].tap()
            elementsQuery.buttons["ChangeSettingsTrackingButton"].tap()
            
            //It shouldn't exist a button before
            app.buttons.firstMatch.tap()
            
            let settingsText = app.staticTexts["SelectedTabTitleName"]
            
            XCTAssertTrue(settingsText.exists)
        }
    }
    
    func test_iPhone_SettingsView_UserTrackingInformation_UserAccessPercentageTrackingNotificationAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["ProductNotification"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            let percentageButton = elementsQuery.buttons["PercentageSettingsPicker"]
            percentageButton.tap()
            
            XCTAssertTrue(percentageButton.exists)
            
            let circularSlider = app.scrollViews.otherElements.staticTexts["CircularSliderCustomView"]
            XCTAssertTrue(circularSlider.exists)
            
            //It shouldn't exist a button before
            app.buttons.firstMatch.tap()
            
            let settingsText = app.staticTexts["SelectedTabTitleName"]
            
            XCTAssertTrue(settingsText.exists)
        }
    }
    
    func test_iPhone_SettingsView_UserTrackingInformation_UserAccessValueTrackingNotificationAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["ProductNotification"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            let percentageButton = elementsQuery.buttons["ValueSettingsPicker"]
            percentageButton.tap()
            
            XCTAssertTrue(percentageButton.exists)
            
            let valuePicker = elementsQuery.pickerWheels["0"]
            
            XCTAssertTrue(valuePicker.exists)
            
            //It shouldn't exist a button before
            app.buttons.firstMatch.tap()
            
            let settingsText = app.staticTexts["SelectedTabTitleName"]
            
            XCTAssertTrue(settingsText.exists)
        }
    }
}
