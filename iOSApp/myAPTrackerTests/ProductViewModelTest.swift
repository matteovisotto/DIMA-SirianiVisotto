//
//  ProductViewModelTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker
import Combine

class ProductViewModelTest: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var cancellables1 = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ProductViewModel_loadData() {
        AppState.shared.isUserLoggedIn = false
        
        let vm = ProductViewModel(product: Product(id: 41, name: "HP cartuccia", shortName: "HP cartuccia", description: "HP cartuccia", link: "https://www.amazon.it/HP-Cartuccia-Originale-dInchiostro-Tricromia/dp/B00VYAWKJY/ref=mp_s_a_1_1_sspa", highestPrice: 100, lowestPrice: 10, images: [], prices: [], category: "HP cartuccia"))
        
        let expectation = XCTestExpectation(description: "Wait to retrieve items from the DB")
        let expectation2 = XCTestExpectation(description: "Wait to retrieve items from the DB 2")
        
        vm.$productPrices
            .dropFirst()
            .sink { products in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.$comments
            .dropFirst()
            .sink { products in
                expectation2.fulfill()
            }
            .store(in: &cancellables1)
        
        vm.loadData()
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertGreaterThan(vm.productPrices.count, 0)
        
        if let test: Int = vm.comments?.comments.count {
            XCTAssertGreaterThan(test, 0)
        }
    }

}
