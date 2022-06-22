//
//  SeeAllViewModelTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker
import Combine

class SeeAllViewModelTest: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SeeAllViewModel_initializeWithCorrectTitle() {
        let title: String = "Most Tracked"
        let apiUrl: String = AppConstant.getMostTracked
        
        let vm = SeeAllViewModel(apiUrl: apiUrl, viewTitle: title)
        
        XCTAssertEqual(vm.viewTitle, title)
    }
}
