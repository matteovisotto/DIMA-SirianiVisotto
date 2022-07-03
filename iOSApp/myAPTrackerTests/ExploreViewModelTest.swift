//
//  ExploreViewModelTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker
import Combine

class ExploreViewModelTest: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var cancellables1 = Set<AnyCancellable>()
    var cancellables2 = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ExploreViewModel_initialization() {
        let vm = ExploreViewModel()
        
        let expectation = XCTestExpectation(description: "Wait to retrieve items from the DB")
        let expectation2 = XCTestExpectation(description: "Wait to retrieve items from the DB 2")
        let expectation3 = XCTestExpectation(description: "Wait to retrieve items from the DB 3")
        
        vm.$mostTracked
            .dropFirst()
            .sink { products in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.$biggestPercentageDrop
            .dropFirst()
            .sink { products in
                expectation2.fulfill()
            }
            .store(in: &cancellables1)
        
        vm.$biggestRangeDrop
            .dropFirst()
            .sink { products in
                expectation3.fulfill()
            }
            .store(in: &cancellables2)
        
        wait(for: [expectation], timeout: 3)
        
        sleep(20)
        
        XCTAssertGreaterThan(vm.mostTracked.count, 0)
        XCTAssertGreaterThan(vm.biggestRangeDrop.count, 0)
        XCTAssertGreaterThan(vm.biggestPercentageDrop.count, 0)
    }

}
