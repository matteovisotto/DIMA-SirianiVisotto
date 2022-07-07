//
//  ProductViewiPadUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 02/07/22.
//

import XCTest

class ProductViewiPadUITest: XCTestCase {

    let app = XCUIApplication()
    var userIsLogged = false
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom != .pad, "Only test for iPad")
        app.launch()
        
        if (app.staticTexts["HomeViewLastProductText"].exists) {
            userIsLogged = true
        }
        app.scrollViews.buttons["HomeViewMostrTrackedButton0"].tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_iPad_ProductView_MaxAndMinTexts_CheckThatMaximumPriceIsHigherThanMinimum() {
        let elementsQuery = app.otherElements
        let priceButton = elementsQuery.buttons.element(boundBy: 1)
        
        XCTAssertTrue(priceButton.exists)
        
        let highestPrice = app.otherElements.staticTexts["ProductViewHighestPrice"]
        let lowestPrice = app.otherElements.staticTexts["ProductViewLowestPrice"]
                
        XCTAssertTrue(highestPrice.exists)
        XCTAssertTrue(lowestPrice.exists)
        
        let highestPriceValue: Double = Double(highestPrice.label) ?? 0
        let lowestPriceValue: Double = Double(lowestPrice.label) ?? 0
        
        XCTAssertTrue(highestPriceValue >= lowestPriceValue)
    }
    
    func test_iPad_ProductView_DetailButton_CorrectlyMoveToDetailPage() {
        let name = app.otherElements.scrollViews.staticTexts["DetailViewName"]
        let category = app.otherElements.scrollViews.staticTexts["DetailViewCategory"]
        let description = app.otherElements.scrollViews.staticTexts["DetailViewDescription"]
                
        XCTAssertTrue(name.exists)
        XCTAssertTrue(category.exists)
        XCTAssertTrue(description.exists)
    }
    
    func test_iPad_ProductView_CommentButton_CorrectlyMoveToCommentPageAndCheckIfTextFieldIsVisble() {
        if (userIsLogged) {
            let elementsQuery = app.otherElements
            var commentButton: XCUIElement
            if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                commentButton = elementsQuery.buttons.element(boundBy: 4)
            } else {
                commentButton = elementsQuery.buttons.element(boundBy: 7)
            }
            commentButton.tap()
            
            XCTAssertTrue(commentButton.exists)
                        
            let commentTextField = app.otherElements.textFields["CommentViewCommentTextField"]
            XCTAssertTrue(commentTextField.exists)
        }
    }
    
    func test_iPad_ProductView_CommentButton_CorrectlyMoveToCommentPageAndCheckThatTextFieldIsNotVisible() {
        if (!userIsLogged) {
            let elementsQuery = app.otherElements
            var commentButton: XCUIElement
            if (UIScreen.main.bounds.width < UIScreen.main.bounds.height) {
                commentButton = elementsQuery.buttons.element(boundBy: 4)
            } else {
                commentButton = elementsQuery.buttons.element(boundBy: 7)
            }
            
            XCTAssertTrue(commentButton.exists)
            
            let commentTextField = app.otherElements.scrollViews.textFields["CommentViewCommentTextField"]
            XCTAssertFalse(commentTextField.exists)
        }
    }
    
    func test_iPad_ProductView_TrackingSettingsOptionsButton_OpenSettingsAndCloseIt() {
        if (userIsLogged) {
            app.buttons["ProductViewSettingsTrackingButton"].tap()
            if (app.buttons["ProductViewSettingsButton"].exists){
                app.buttons["ProductViewSettingsButton"].tap()
                
                let topOffset = CGVector(dx: 0.5, dy: 1.1)

                let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)
                
                cellFarRightCoordinate.press(forDuration: 1)
                
                XCTAssertTrue(app.buttons["ProductViewSettingsTrackingButton"].isHittable)
            }
        }
    }
    
    func test_iPad_ProductView_TrackingSettingsOptionsButton_OpenSettings() {
        if (userIsLogged) {
            app.buttons["ProductViewSettingsTrackingButton"].tap()
            if (app.buttons["ProductViewSettingsButton"].exists){
                app.buttons["ProductViewSettingsButton"].tap()
                
                let text = app.scrollViews.staticTexts["UpdateTrackingViewNotificationText"]
                XCTAssertTrue(text.exists)
            }
        }
    }
    
    func test_iPad_ProductView_TrackingSettings_NeverTab() {
        if (userIsLogged) {
            app.buttons["ProductViewSettingsTrackingButton"].tap()
            if (app.buttons["ProductViewSettingsButton"].exists){
                app.buttons["ProductViewSettingsButton"].tap()
                let elementsQuery = app.scrollViews.otherElements
                let neverButton = elementsQuery.buttons["UpdateTrackingViewNeverButton"].waitForExistence(timeout: 10)
                XCTAssertTrue(neverButton)
                
                elementsQuery.buttons["UpdateTrackingViewNeverButton"].tap()
                
                let neverText = app.scrollViews.staticTexts["UpdateTrackingViewNeverNotificationText"]
                
                XCTAssertTrue(neverText.exists)
            }
        }
    }
    
    func test_iPad_ProductView_TrackingSettings_PercentageTab() {
        if (userIsLogged) {
            app.buttons["ProductViewSettingsTrackingButton"].tap()
            if (app.buttons["ProductViewSettingsButton"].exists){
                app.buttons["ProductViewSettingsButton"].tap()
                let elementsQuery = app.scrollViews.otherElements
                let neverButton = elementsQuery.buttons["UpdateTrackingViewPercentageButton"].waitForExistence(timeout: 10)
                XCTAssertTrue(neverButton)
                
                elementsQuery.buttons["UpdateTrackingViewPercentageButton"].tap()
                
                let percentageText = app.scrollViews.staticTexts["UpdateTrackingViewPercentageNotificationText"]
                
                XCTAssertTrue(percentageText.exists)
            }
        }
    }
    
    func test_iPad_ProductView_TrackingSettings_ValueTab() {
        if (userIsLogged) {
            app.buttons["ProductViewSettingsTrackingButton"].tap()
            if (app.buttons["ProductViewSettingsButton"].exists){
                app.buttons["ProductViewSettingsButton"].tap()
                
                let elementsQuery = app.scrollViews.otherElements
                let neverButton = elementsQuery.buttons["UpdateTrackingViewValueButton"].waitForExistence(timeout: 10)
                XCTAssertTrue(neverButton)
                
                elementsQuery.buttons["UpdateTrackingViewValueButton"].tap()
                
                let valueText = app.scrollViews.staticTexts["UpdateTrackingViewValueNotificationText"]
                
                XCTAssertTrue(valueText.exists)
            }
        }
    }
    
    func test_iPad_ProductView_TrackingSettings_AlwaysTab() {
        if (userIsLogged) {
            app.buttons["ProductViewSettingsTrackingButton"].tap()
            if (app.buttons["ProductViewSettingsButton"].exists){
                app.buttons["ProductViewSettingsButton"].tap()
                
                let elementsQuery = app.scrollViews.otherElements
                let neverButton = elementsQuery.buttons["UpdateTrackingViewAlwaysButton"].waitForExistence(timeout: 10)
                XCTAssertTrue(neverButton)
                
                elementsQuery.buttons["UpdateTrackingViewAlwaysButton"].tap()
                
                let alwaysText = app.scrollViews.staticTexts["UpdateTrackingViewAlwaysNotificationText"]
                
                XCTAssertTrue(alwaysText.exists)
            }
        }
    }
    
    func test_iPad_ProductView_TrackingSettingsOptionsButton_UserStopTrackingOrStartTrackingButton() {
        if (userIsLogged) {
            app.buttons["ProductViewSettingsTrackingButton"].tap()
            if (app.buttons["ProductViewSettingsButton"].exists){
                let stopTrackProduct = app.buttons["ProductViewStopTrackProduct"]
                XCTAssertTrue(stopTrackProduct.exists)
            } else {
                let startTrackProduct = app.buttons["ProductViewStartTrackProduct"]
                XCTAssertTrue(startTrackProduct.exists)
            }
        }
    }
}
