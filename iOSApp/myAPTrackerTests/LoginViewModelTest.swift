//
//  LoginViewModelTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker

class LoginViewModelTest: XCTestCase {

    var vm: LoginViewModel?
    
    override func setUpWithError() throws {
        vm = LoginViewModel(.constant(true))
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_LoginViewModel_isNotCredentialInserted_credentialNotInserted() {
        vm!.email = "email@email.com"
        vm!.password = ""
        
        XCTAssertTrue(vm!.isNotCredentialInserted())
    }
    
    func test_LoginViewModel_isNotCredentialInserted_credentialInserted() {
        vm!.email = "email@email.com"
        vm!.password = "password"
        
        XCTAssertFalse(vm!.isNotCredentialInserted())
    }
}
