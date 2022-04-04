//
//  FacebookAuth.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation
import FacebookLogin

class FacebookAuth {
    var delegate: LoginDelegate? = nil
    
    func login() -> Void {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], viewController: nil) { loginResult in
                    switch loginResult {
                    case .failed(let error):
                        self.delegate?.didFinishLogin(withError: error.localizedDescription)
                    case .cancelled:
                        self.delegate?.didFinishLogin(withError: NSLocalizedString("facebookAuthCancel", comment: "You have canceled the authentication process"))
                    case .success(granted: _, declined: _, token: _):
                        if let token = AccessToken.current {
                            let appAuth = AppSocialAuth(token: token.tokenString, social: .facebook)
                            appAuth.backendLogin { error, message, credential in
                                if error {
                                    self.delegate?.didFinishLogin(withError: message ?? NSLocalizedString("socialBackendUnknownError", comment: "Unknown error while authenticating in the backend"))
                                    return
                                }
                                guard let credential = credential else {
                                    self.delegate?.didFinishLogin(withError: message ?? NSLocalizedString("socialBackendUnknownError", comment: "Unknown error while authenticating in the backend"))
                                    return
                                }
                                self.delegate?.didFinishLogin(withSuccessCredential: credential)

                            }
                        }
                    }
                }
    }
    
}
