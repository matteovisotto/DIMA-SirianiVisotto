//
//  TrackedViewModelTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker
import Combine

class TrackedViewModelTest: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TrackedViewModel_initialization() {
        AppState.shared.isUserLoggedIn = false
        
        let vm = TrackedViewModel(showLogin: .constant(false))
        
        vm.trackingObjects.append(TrackedProduct(id: 1, name: "Apple", shortName: "Apple", description: "Apple", link: "link", highestPrice: 100, lowestPrice: 10, createdAt: "time", lastUpdate: "lastUpdate", trackingSince: "since", dropKey: "percentage", dropValue: 10, images: [], category: "Apple"))
        
        vm.trackingObjects.append(TrackedProduct(id: 2, name: "Computer", shortName: "Computer", description: "Computer", link: "link", highestPrice: 100, lowestPrice: 10, createdAt: "time", lastUpdate: "lastUpdate", trackingSince: "since", dropKey: "percentage", dropValue: 10, images: [], category: "Computer"))
        
        vm.searchText = "Apple"
        
        XCTAssertEqual(vm.searchingObjects.count, 0)
        
        let expectation = XCTestExpectation(description: "Wait to search")
        
        vm.$searchingObjects
            .dropFirst()
            .sink { products in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.performSearch()
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssertGreaterThan(vm.searchingObjects.count, 0)
    }

}
