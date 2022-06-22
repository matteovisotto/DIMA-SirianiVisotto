//
//  RegisterViewModelTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker

class RegisterViewModelTest: XCTestCase {

    var vm: RegisterViewModel?
    
    override func setUpWithError() throws {
        vm = RegisterViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_RegisterViewModel_isFormInvalid_conditionNotAccepted() {
        vm!.name = "Name"
        vm!.surname = "Surname"
        vm!.email = "email@email.com"
        vm!.password = "password"
        vm!.passwordCnf = "password"
        vm!.termsAndCondition = false
        
        XCTAssertTrue(vm!.isFormInvalid())
    }
    
    func test_RegisterViewModel_isFormInvalid_passwordsNotMatching() {
        vm!.name = "Name"
        vm!.surname = "Surname"
        vm!.email = "email@email.com"
        vm!.password = "password"
        vm!.passwordCnf = "passwordù"
        vm!.termsAndCondition = true
        
        XCTAssertTrue(vm!.isFormInvalid())
    }
    
    func test_RegisterViewModel_isFormInvalid_invalidEmail() {
        vm!.name = "Name"
        vm!.surname = "Surname"
        vm!.email = "email"
        vm!.password = "password"
        vm!.passwordCnf = "password"
        vm!.termsAndCondition = true
        
        XCTAssertTrue(vm!.isFormInvalid())
    }
    
    func test_RegisterViewModel_isValidEmail_valid() {
        XCTAssertTrue(vm!.isValidEmail("email@email.com"))
    }
    
    func test_RegisterViewModel_isValidEmail_notValid() {
        XCTAssertFalse(vm!.isValidEmail("email@emailcom"))
    }
}
