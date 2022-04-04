//
//  LoginViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    func authWithGoogle() -> Void {
        self.isLoading = true
        let googleAuth = GoogleAuth()
        googleAuth.delegate = self
        googleAuth.login()
    }
    
    func authWithFacebook() -> Void {
        self.isLoading = true
        let facebookAuth = FacebookAuth()
        facebookAuth.delegate = self
        facebookAuth.login()
    }
    
    func authLocal() -> Void {
        self.isLoading = true
    }
    
    func isNotCredentialInserted() -> Bool {
        return (self.email.isEmpty || self.email == "" || self.password.isEmpty || self.password == "")
    }
}

extension LoginViewModel: LoginDelegate {
    
    func didFinishLogin(withSuccessCredential credential: LoginCredential) {
        KeychainHelper.standard.save(credential, service: AppConstant.keychainCredentialKey, account: AppConstant.backendDomain)
        self.isLoading = false
    }
    
    func didFinishLogin(withError error: String) {
        self.isLoading = false
        print(error)
    }
    
}
