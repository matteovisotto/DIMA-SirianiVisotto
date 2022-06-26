//
//  UserProfileViewModelTest.swift
//  myAPTrackerTests
//
//  Created by Tia on 22/06/22.
//

import XCTest
@testable import myAPTracker

class UserProfileViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UserProfileViewModel_initialization() {
        if (AppState.shared.isUserLoggedIn) {
            AppState.shared.userIdentity?.name = "Name"
            AppState.shared.userIdentity?.surname = "Surname"
            AppState.shared.userIdentity?.username = "Username"
            
            let vm = UserProfileViewModel()
            
            XCTAssertEqual(AppState.shared.userIdentity?.name, vm.name)
            XCTAssertEqual(AppState.shared.userIdentity?.surname, vm.surname)
            XCTAssertEqual(AppState.shared.userIdentity?.username, vm.username)
        }
    }
    
    func test_UserProfileViewModel_validatePassword_valid() {
        let vm = UserProfileViewModel()
        
        vm.password = "password"
        vm.passwordCnf = "password"
        vm.oldPassword = "oldPassword"
        
        XCTAssertTrue(vm.validatePassword())
    }
    
    func test_UserProfileViewModel_validatePassword_notValid() {
        let vm = UserProfileViewModel()
        
        vm.password = "password"
        vm.passwordCnf = "password"
        vm.oldPassword = ""
        
        XCTAssertFalse(vm.validatePassword())
    }
    
    func test_UserProfileViewModel_validateUserData_valid() {
        if (AppState.shared.isUserLoggedIn) {
            AppState.shared.userIdentity?.name = "Name"
            AppState.shared.userIdentity?.surname = "Surname"
            AppState.shared.userIdentity?.username = "Username"
            
            let vm = UserProfileViewModel()
            
            XCTAssertTrue(vm.validateUserData())
        }
    }
    
    func test_UserProfileViewModel_validateUserData_notValid() {
        AppState.shared.userIdentity?.name = "Name"
        AppState.shared.userIdentity?.surname = "Surname"
        AppState.shared.userIdentity?.username = ""
        
        let vm = UserProfileViewModel()
        
        XCTAssertFalse(vm.validateUserData())
    }
}
