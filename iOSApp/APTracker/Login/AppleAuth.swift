//
//  AppleAuth.swift
//  APTracker
//
//  Created by Matteo Visotto on 28/04/22.
//

import Foundation
import AuthenticationServices

class AppleAuth: NSObject {
    
    public var delegate: LoginDelegate? = nil
    
    public func login() -> Void {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
    }
    
}

extension AppleAuth: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            guard let tokenData = appleIDCredential.authorizationCode else {
                self.delegate?.didFinishLogin(withError: NSLocalizedString("Unable to find Apple Token", comment: "Unable to find Apple Token"))
                return
            }
            guard let token = String(data: tokenData, encoding: .utf8) else {
                self.delegate?.didFinishLogin(withError: NSLocalizedString("Unable to find Apple Token", comment: "Unable to find Apple Token"))
                return
            }
            //Send the authorization to the backend
            let taskManager = TaskManager(urlString: AppConstant.appleLoginURL,method: .POST, parameters: ["aToken":token])
            taskManager.execute {result, content, data in
                LoginCredential.parseAndDelegate(self.delegate, result: result, content: content, data: data)
            }
            
            //Test Data
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            
        } else {
            self.delegate?.didFinishLogin(withError: NSLocalizedString("Unable to find Apple Credential", comment: "Unable to find Apple Credential"))
        }
              
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.delegate?.didFinishLogin(withError: error.localizedDescription)
    }
}

