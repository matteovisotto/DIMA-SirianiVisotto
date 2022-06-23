//
//  SettingsViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 23/06/22.
//

import XCTest
@testable import myAPTracker

class SettingsViewUITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        app.buttons["SettingsTabBar"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SettingsView_UserLoginRegister_UserIsLogged() {
        let loginButton = app.tables.buttons["LoginOrCreateAnAccountButton"]
        
        XCTAssertFalse(loginButton.exists)
    }
    
    func test_SettingsView_UserProfileInformation_UserShowInfo() {
        app.tables.buttons["UserProfileNavigationLink"].tap()
                
        let profileText = app.scrollViews.otherElements.staticTexts["ProfileText"]
        
        XCTAssertTrue(profileText.exists)
    }
    
    func test_SettingsView_UserProfileInformation_UserShowInfoAndGoBack() {
        app.tables/*@START_MENU_TOKEN@*/.buttons["UserProfileNavigationLink"]/*[[".cells[\"Mattia Siriani, tototia98@gmail.com\"]",".buttons[\"Mattia Siriani, tototia98@gmail.com\"]",".buttons[\"UserProfileNavigationLink\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["ProfileText"]/*[[".staticTexts[\"Profile\"]",".staticTexts[\"ProfileText\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.buttons["Left"].tap()
        let settingsText = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(settingsText.exists)
    }
    
    func test_SettingsView_UserTrackingInformation_UserModifyToNeverTrackingNotificationAndGoBack() {
        app.tables.buttons["ProductNotification"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let neverButton = elementsQuery.segmentedControls.containing(.button, identifier:"NeverSettingsPicker").buttons["NeverSettingsPicker"]
        neverButton.tap()
        
        XCTAssertTrue(neverButton.exists)
        
        elementsQuery.children(matching: .segmentedControl).element(boundBy: 1).buttons["NeverCommentButton"].tap()
        elementsQuery.buttons["ChangeSettingsTrackingButton"].tap()
        app.buttons["Left"].tap()
        
        let settingsText = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(settingsText.exists)
    }
    
    func test_SettingsView_UserTrackingInformation_UserModifyToAlwaysTrackingNotificationAndGoBack() {
        app.tables.buttons["ProductNotification"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let alwaysButton = elementsQuery.segmentedControls.containing(.button, identifier:"AlwaysSettingsPicker").buttons["AlwaysSettingsPicker"]
        alwaysButton.tap()
        
        XCTAssertTrue(alwaysButton.exists)
        
        elementsQuery.children(matching: .segmentedControl).element(boundBy: 1).buttons["AlwaysCommentButton"].tap()
        elementsQuery.buttons["ChangeSettingsTrackingButton"].tap()
        app.buttons["Left"].tap()
        
        let settingsText = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(settingsText.exists)
        //XCTAssertTrue(PreferenceManager.shared.getCommentPolicy() == "always")
    }
    
    func test_SettingsView_UserTrackingInformation_UserAccessPercentageTrackingNotificationAndGoBack() {
        app.tables.buttons["ProductNotification"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let percentageButton = elementsQuery.segmentedControls.containing(.button, identifier:"PercentageSettingsPicker").buttons["PercentageSettingsPicker"]
        percentageButton.tap()
        
        XCTAssertTrue(percentageButton.exists)
        
        //let circularSlider = elementsQuery.children(matching: .segmentedControl).otherElements["CircularSliderCustomView"]
        
        //XCTAssertTrue(circularSlider.exists)
        
        app.buttons["Left"].tap()
        
        let settingsText = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(settingsText.exists)
        //XCTAssertTrue(PreferenceManager.shared.getCommentPolicy() == "always")
    }
    
    func test_SettingsView_UserTrackingInformation_UserAccessValueTrackingNotificationAndGoBack() {
        app.tables.buttons["ProductNotification"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let valueButton = elementsQuery.segmentedControls.containing(.button, identifier:"ValueSettingsPicker").buttons["ValueSettingsPicker"]
        valueButton.tap()
        
        XCTAssertTrue(valueButton.exists)
        
        //let circularSlider = elementsQuery.children(matching: .segmentedControl).otherElements["CircularSliderCustomView"]
        
        //XCTAssertTrue(circularSlider.exists)
        
        app.buttons["Left"].tap()
        
        let settingsText = app.staticTexts["SelectedTabTitleName"]
        
        XCTAssertTrue(settingsText.exists)
        //XCTAssertTrue(PreferenceManager.shared.getCommentPolicy() == "always")
    }
}
