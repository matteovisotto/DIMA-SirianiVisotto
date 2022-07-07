//
//  AddProductViewiPadUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 24/06/22.
//

import XCTest
import Foundation

class AddProductViewiPadUITest: XCTestCase {

    let app = XCUIApplication()
    var userIsLogged = false
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .pad, "Only test for iPad")
        app.launch()
        sleep(5)
        if (app.staticTexts["HomeViewLastProductText"].exists) {
            userIsLogged = true
        }
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
            app.buttons.firstMatch.tap()
        }
        app.buttons["iPadMainViewAddProduct"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_iPad_AddProductView_AmazonView_CloseAmazonView() throws {
        let textField = app.textFields["AddProductViewAmazonTextField"].waitForExistence(timeout: 2)
        
        XCTAssertTrue(textField)
        
        let topOffset = CGVector(dx: 0.5, dy: 1.1)

        let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)

        cellFarRightCoordinate.press(forDuration: 1)
                
        sleep(5)
        
        let topOffset2 = CGVector(dx: 0.95, dy: 0.5)
        let bottomOffset2 = CGVector(dx: 0.05, dy: 0.5)

        let cellFarRightCoordinate2 = app.coordinate(withNormalizedOffset: topOffset2)
        let cellFarLeftCoordinate2 = app.coordinate(withNormalizedOffset: bottomOffset2)
        
        // drag from right to left to delete
        cellFarRightCoordinate2.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate2)
        
        sleep(5)
        
        let mostTrackedText = app.staticTexts["HomeViewMostTrackedText"]
        
        XCTAssertTrue(mostTrackedText.isHittable)
    }
    
    func test_iPad_AddProductView_AddButton_Disabled() throws {
        if (!userIsLogged) {
            let addButton = app.buttons["AddProductViewAddButton"]
            XCTAssertFalse(addButton.isEnabled)
        }
    }
    
    func test_iPad_TrackProductView_TrackButton_Disabled() throws {
        if (userIsLogged) {
            let trackButton = app.buttons["AddProductViewTrackButton"]
            XCTAssertFalse(trackButton.isEnabled)
        }
    }
    
    func test_iPad_AddProductView_AddButton_Enabled() throws {
        if (!userIsLogged) {
            let addButton = app.buttons["AddProductViewAddButton"]
            XCTAssertFalse(addButton.isEnabled)
            
            let textField = app.textFields["AddProductViewAmazonTextField"]
            
            textField.tap()
                        
            sleep(10)
            
            textField.typeText("/dp/B084DWG2VQ/\n")
            
            app.buttons["AddProductViewAmazonSearch"].tap()
            
            let addButtonNew = app.buttons["AddProductViewAddButton"]
            
            sleep(10)
            
            XCTAssertTrue(addButtonNew.isEnabled)
        }
    }
    
    func test_iPad_AddProductView_TrackButton_Enabled() throws {
        if (userIsLogged) {
            let trackButton = app.buttons["AddProductViewTrackButton"]
            XCTAssertFalse(trackButton.isEnabled)
            
            let textField = app.textFields["AddProductViewAmazonTextField"]
            
            textField.tap()
            
            sleep(10)
            
            textField.typeText("/dp/B084DWG2VQ/\n")
            
            app.buttons["AddProductViewAmazonSearch"].tap()
            
            let addButtonNew = app.buttons["AddProductViewTrackButton"]
            
            sleep(10)
            
            XCTAssertTrue(addButtonNew.isEnabled)
        }
    }
    
    func test_iPad_AddProductView_GoBackAndForwardButton_UserNavigate() throws {
        let backButton = app.buttons["AddProductViewGoBackButton"]
        XCTAssertFalse(backButton.isEnabled)
    
        let forwardButton = app.buttons["AddProductViewGoForwardButton"]
        XCTAssertFalse(forwardButton.isEnabled)
        
        let textField = app.textFields["AddProductViewAmazonTextField"]
        
        textField.tap()
        
        sleep(10)
                
        textField.typeText("/dp/B084DWG2VQ/\n")
        
        app.buttons["AddProductViewAmazonSearch"].tap()
        
        let backButtonExist = app.buttons["AddProductViewGoBackButton"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(backButtonExist)
        
        let backButtonNew = app.buttons["AddProductViewGoBackButton"]
        XCTAssertTrue(backButtonNew.isEnabled)
    
        backButtonNew.tap()
        
        let forwardButtonNew = app.buttons["AddProductViewGoForwardButton"]
        XCTAssertTrue(forwardButtonNew.isEnabled)
    }
}
