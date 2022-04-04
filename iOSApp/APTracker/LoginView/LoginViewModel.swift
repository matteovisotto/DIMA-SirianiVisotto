//
//  LoginViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @State var email: String = ""
    @State var password: String = ""
    
    
    func authWithGoogle() -> Void {
        let googleAuth = GoogleAuth()
        googleAuth.delegate = self
        googleAuth.login()
    }
    
    func authWithFacebook() -> Void {
        
    }
}

extension LoginViewModel: LoginDelegate {
    
    func didFinishLogin(withSuccessCredential: LoginCredential) {
        
    }
    
    func didFinishLogin(withError error: String) {
        
    }
    
}
