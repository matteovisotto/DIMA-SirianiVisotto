//
//  TrackingSettingViewModelTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker

class TrackingSettingViewModelTest: XCTestCase {

    var vm: TrackingSettingViewModel?
    
    override func setUpWithError() throws {
        vm = TrackingSettingViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
    }
    
    func test_TrackingSettingViewModel_saveSettingValue_saved() {        
        vm!.dropKey = "value"
        vm!.dropValue = "100"
        vm!.commentPolicy = "never"
        
        vm!.saveSetting(percentage: false)
        
        XCTAssertEqual(PreferenceManager.shared.getDropKey(), vm!.dropKey)
        XCTAssertEqual(String(format: "%.0f", PreferenceManager.shared.getDropValue()), vm!.dropValue)
        XCTAssertEqual(PreferenceManager.shared.getCommentPolicy(), vm!.commentPolicy)
    }
    
    func test_TrackingSettingViewModel_saveSettingPercentage_saved() {
        vm!.dropKey = "percentage"
        vm!.dropValuePercentage = "50"
        vm!.commentPolicy = "never"
        
        vm!.saveSetting(percentage: true)
        
        XCTAssertEqual(PreferenceManager.shared.getDropKey(), vm!.dropKey)
        XCTAssertEqual(String(format: "%.0f", PreferenceManager.shared.getDropValue()), vm!.dropValuePercentage)
        XCTAssertEqual(PreferenceManager.shared.getCommentPolicy(), vm!.commentPolicy)
    }
    
    func test_TrackingSettingViewModel_validateSettingsNone_valid() {
        vm!.dropKey = "none"
        XCTAssertEqual(true, vm!.validateSettings())
    }
    
    func test_TrackingSettingViewModel_validateSettingsAlways_valid() {
        vm!.dropKey = "always"
        XCTAssertEqual(true, vm!.validateSettings())
    }
    
    func test_TrackingSettingViewModel_validateSettingsPercentage_valid() {
        vm!.dropKey = "percentage"
        vm!.dropValuePercentage = "50"
        vm!.commentPolicy = "never"
        
        vm!.saveSetting(percentage: true)
        
        XCTAssertEqual(true, vm!.validateSettings())
    }
    
    func test_TrackingSettingViewModel_validateSettingsPercentage_notValid() {
        vm!.dropKey = "percentage"
        vm!.dropValuePercentage = "0"
        vm!.commentPolicy = "never"
        
        vm!.saveSetting(percentage: true)
        
        XCTAssertEqual(false, vm!.validateSettings())
    }
    
    func test_TrackingSettingViewModel_validateSettingsValue_valid() {
        vm!.dropKey = "value"
        vm!.dropValue = "100"
        vm!.commentPolicy = "never"
        
        vm!.saveSetting(percentage: false)
        
        XCTAssertEqual(true, vm!.validateSettings())
    }
    
    func test_TrackingSettingViewModel_validateSettingsValue_notValid() {
        vm!.dropKey = "value"
        vm!.dropValue = "0"
        vm!.commentPolicy = "never"
        
        vm!.saveSetting(percentage: false)
        
        XCTAssertEqual(false, vm!.validateSettings())
    }
}
