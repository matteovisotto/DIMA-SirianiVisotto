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
    
    private var isPresented: Binding<Bool>
    
    init(_ isPresented: Binding<Bool>) {
        self.isPresented = isPresented
    }
    
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
    
    func authWithApple() -> Void {
        
    }
    
    func authLocal() -> Void {
        self.isLoading = true
        let localAuth = LocalAuth()
        localAuth.delegate = self
        localAuth.login(email: self.email, password: self.password)
    }
    
    func isNotCredentialInserted() -> Bool {
        return (self.email.isEmpty || self.email == "" || self.password.isEmpty || self.password == "")
    }
    
    func dismiss() -> Void {
        self.isPresented.wrappedValue = false
    }
}

extension LoginViewModel: LoginDelegate {
    
    func didFinishLogin(withSuccessCredential credential: LoginCredential) {
        KeychainHelper.standard.save(credential, service: AppConstant.keychainCredentialKey, account: AppConstant.backendDomain)
        self.isLoading = false
        self.email = ""
        self.password = ""
        AppState.shared.reloadState()
        isPresented.wrappedValue = false
    }
    
    func didFinishLogin(withError error: String) {
        self.isLoading = false
        print(error)
    }
    
}
