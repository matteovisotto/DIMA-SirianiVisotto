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
                            let taskManager = TaskManager(urlString: AppConstant.facebookLoginURL, method: .POST, parameters: ["fbToken": token.tokenString])
                            taskManager.execute { result, content, data in
                                LoginCredential.parseAndDelegate(self.delegate, result: result, content: content, data: data)
                            }
                        }
                    }
                }
    }
    
}
