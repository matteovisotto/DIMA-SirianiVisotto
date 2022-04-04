//
//  AppState.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    
    public static let shared: AppState = AppState()
    
    @Published var isUserLoggedIn: Bool = false
    var userCredential: LoginCredential? = nil
    
    init() {
        reloadState()
    }
    
    func reloadState() {
        let credential = KeychainHelper.standard.read(service: AppConstant.keychainCredentialKey, account: AppConstant.backendDomain, type: LoginCredential.self)
         if let credential = credential {
             self.userCredential = credential
             self.isUserLoggedIn = true
         }
    }
    
    func logout() {
        KeychainHelper.standard.delete(service: AppConstant.keychainCredentialKey, account: AppConstant.backendDomain)
        self.isUserLoggedIn = false
    }
    
}
