//
//  SettingsViewiPadUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 02/07/22.
//

import XCTest

class SettingsViewiPadUITest: XCTestCase {

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
        
        app.otherElements.buttons["iPadMainButton3"].tap()
        
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

    func test_iPad_SettingsView_UserLoginRegister_UserIsLogged() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            let loginButton = app.tables.buttons["LoginOrCreateAnAccountButton"]
            XCTAssertFalse(loginButton.exists)
        } else {
            let loginButton = app.tables.buttons["LoginOrCreateAnAccountButton"]
            XCTAssertTrue(loginButton.exists)
        }
    }
    
    func test_iPad_SettingsView_UserLoginRegister_UserIsNotLoggedAndGoToLoginPageAndReturnToPreviousPage() {
        if (app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            let loginButton = app.tables.buttons["LoginOrCreateAnAccountButton"]
            XCTAssertTrue(loginButton.exists)
            
            loginButton.tap()
            
            sleep(5)
            
            let loginText = app.staticTexts["LoginViewLoginText"]
            
            XCTAssertTrue(loginText.exists)
            
            let topOffset = CGVector(dx: 0.5, dy: 1.1)

            let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)
            
            cellFarRightCoordinate.press(forDuration: 1)
            
            let loginButtonNew = app.tables.buttons["LoginOrCreateAnAccountButton"]
            XCTAssertTrue(loginButtonNew.exists)
        }
    }
    
    func test_iPad_SettingsView_UserProfileInformation_UserShowInfoAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["UserProfileNavigationLink"].tap()
            
            XCTAssertTrue(app.scrollViews.buttons["UserProfileViewiPadChange"].exists)
            
            if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                app.buttons.firstMatch.tap()
            } else {
                app.buttons.firstMatch.tap()
                app.buttons.firstMatch.tap()
            }
            
            let settingsButton = app.tables.buttons["UserProfileNavigationLink"]
            
            XCTAssertTrue(settingsButton.exists)
        }
    }
    
    func test_iPad_SettingsView_UserTrackingInformation_UserModifyToNeverTrackingNotificationAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["ProductNotification"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            let neverButton = elementsQuery.segmentedControls.containing(.button, identifier:"NeverSettingsPicker").buttons["NeverSettingsPicker"]
            neverButton.tap()
            
            XCTAssertTrue(neverButton.exists)
            
            elementsQuery.children(matching: .segmentedControl).element(boundBy: 1).buttons["NeverCommentButton"].tap()
            elementsQuery.buttons["ChangeSettingsTrackingButton"].tap()
            
            if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                app.buttons.firstMatch.tap()
            } else {
                app.buttons.firstMatch.tap()
                app.buttons.firstMatch.tap()
            }

            let settingsButton = app.tables.buttons["UserProfileNavigationLink"]
            
            XCTAssertTrue(settingsButton.exists)
        }
    }
    
    func test_iPad_SettingsView_UserTrackingInformation_UserModifyToAlwaysTrackingNotificationAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["ProductNotification"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            let alwaysButton = elementsQuery.segmentedControls.containing(.button, identifier:"AlwaysSettingsPicker").buttons["AlwaysSettingsPicker"]
            alwaysButton.tap()
            
            XCTAssertTrue(alwaysButton.exists)
            
            elementsQuery.children(matching: .segmentedControl).element(boundBy: 1).buttons["AlwaysCommentButton"].tap()
            elementsQuery.buttons["ChangeSettingsTrackingButton"].tap()
            
            //It shouldn't exist a button before
            if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                app.buttons.firstMatch.tap()
            } else {
                app.buttons.firstMatch.tap()
                app.buttons.firstMatch.tap()
            }
            
            let settingsButton = app.tables.buttons["UserProfileNavigationLink"]
            
            XCTAssertTrue(settingsButton.exists)
        }
    }
    
    func test_iPad_SettingsView_UserTrackingInformation_UserAccessPercentageTrackingNotificationAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["ProductNotification"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            let percentageButton = elementsQuery.buttons["PercentageSettingsPicker"]
            percentageButton.tap()
            
            XCTAssertTrue(percentageButton.exists)
            
            let circularSlider = app.scrollViews.otherElements.staticTexts["CircularSliderCustomView"]
            XCTAssertTrue(circularSlider.exists)
            
            //It shouldn't exist a button before
            if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                app.buttons.firstMatch.tap()
            } else {
                app.buttons.firstMatch.tap()
                app.buttons.firstMatch.tap()
            }
            
            let settingsButton = app.tables.buttons["UserProfileNavigationLink"]
            
            XCTAssertTrue(settingsButton.exists)
        }
    }
    
    func test_iPad_SettingsView_UserTrackingInformation_UserAccessValueTrackingNotificationAndGoBack() {
        if (!app.tables.buttons["LoginOrCreateAnAccountButton"].waitForExistence(timeout: 2)) {
            app.tables.buttons["ProductNotification"].tap()
            
            let elementsQuery = app.scrollViews.otherElements
            let percentageButton = elementsQuery.buttons["ValueSettingsPicker"]
            percentageButton.tap()
            
            XCTAssertTrue(percentageButton.exists)
            
            let valuePicker = elementsQuery.pickerWheels["0"]
            
            XCTAssertTrue(valuePicker.exists)
            
            //It shouldn't exist a button before
            if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                app.buttons.firstMatch.tap()
            } else {
                app.buttons.firstMatch.tap()
                app.buttons.firstMatch.tap()
            }
            
            let settingsButton = app.tables.buttons["UserProfileNavigationLink"]
            
            XCTAssertTrue(settingsButton.exists)
        }
    }
}
