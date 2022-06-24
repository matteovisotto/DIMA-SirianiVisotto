//
//  ProductViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 24/06/22.
//

import XCTest

class ProductViewUITest: XCTestCase {

    let app = XCUIApplication()
    var userIsLogged = true
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.buttons["HomeTabBar"].tap()
        if (!app.staticTexts["HomeViewLastAddedText"].exists) {
            userIsLogged = false
        }
        app.scrollViews.otherElements.scrollViews.otherElements.buttons.element(boundBy: 1).tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ProductView_MaxAndMinTexts_CheckThatMaximumPriceIsHigherThanMinimum() {
        let elementsQuery = app.otherElements
        let priceButton = elementsQuery.buttons.element(boundBy: 1)
        priceButton.tap()
        
        XCTAssertTrue(priceButton.exists)
        
        let highestPrice = app.otherElements.staticTexts["ProductViewHighestPrice"]
        let lowestPrice = app.otherElements.staticTexts["ProductViewLowestPrice"]
                
        XCTAssertTrue(highestPrice.exists)
        XCTAssertTrue(lowestPrice.exists)
        
        //Check if highestPrice > lowestPrice
    }
    
    func test_ProductView_DetailButton_CorrectlyMoveToDetailPage() {
        let elementsQuery = app.otherElements
        let detailButton = elementsQuery.buttons.element(boundBy: 2)
        detailButton.tap()
        
        XCTAssertTrue(detailButton.exists)
        
        let name = app.otherElements.scrollViews.staticTexts["DetailViewName"]
        let category = app.otherElements.scrollViews.staticTexts["DetailViewCategory"]
        let description = app.otherElements.scrollViews.staticTexts["DetailViewDescription"]
                
        XCTAssertTrue(name.exists)
        XCTAssertTrue(category.exists)
        XCTAssertTrue(description.exists)
    }
    
    func test_ProductView_CommentButton_CorrectlyMoveToCommentPageAndCheckIfTextFieldIsVisble() {
        if (userIsLogged) {
            let elementsQuery = app.otherElements
            let commentButton = elementsQuery.buttons.element(boundBy: 3)
            commentButton.tap()
            
            XCTAssertTrue(commentButton.exists)
            
            let commentTextField = app.otherElements.scrollViews.textFields["CommentViewCommentTextField"]
            XCTAssertTrue(commentTextField.exists)
        }
    }
    
    func test_ProductView_CommentButton_CorrectlyMoveToCommentPageAndCheckThatTextFieldIsNotVisible() {
        if (!userIsLogged) {
            let elementsQuery = app.otherElements
            let commentButton = elementsQuery.buttons.element(boundBy: 3)
            commentButton.tap()
            
            XCTAssertTrue(commentButton.exists)
            
            let commentTextField = app.otherElements.scrollViews.textFields["CommentViewCommentTextField"]
            XCTAssertFalse(commentTextField.exists)
        }
    }
}
