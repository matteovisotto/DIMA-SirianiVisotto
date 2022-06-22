//
//  FilterViewTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker
import Combine

class FilterViewTest: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_FilterViewModel_initialization_addedCategories() {
        let vm = FilterViewModel(isPresented: .constant(true), selectedCategories: .constant(["Apple"]))
        
        let expectation = XCTestExpectation(description: "Wait to retrieve items from the DB")
        
        vm.$categories
            .dropFirst()
            .sink { products in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 3)
        
        XCTAssertGreaterThan(vm.categories.count, 0)
    }

}
