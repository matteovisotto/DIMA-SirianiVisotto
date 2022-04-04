//
//  GoogleAuth.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation
import GoogleSignIn

class GoogleAuth {
    private var googleClientID = "69497537086-q9peoqc9d892p0ps5jv95fmut3h7v9dh.apps.googleusercontent.com"
    var delegate: LoginDelegate? = nil
    
    func login() -> Void {
        let gConf = GIDConfiguration.init(clientID: self.googleClientID)
        guard let rootVC = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {delegate?.didFinishLogin(withError: NSLocalizedString("rootVCNotFound", comment: "Unable to find root view controller")); return}
        GIDSignIn.sharedInstance.signIn(
                    with: gConf,
                    presenting: rootVC,
                    callback: { user, error in
                        if let error = error {
                            self.delegate?.didFinishLogin(withError: error.localizedDescription)
                            return
                        }
                        guard let user = user else { return }
                        user.authentication.do { authentication, error in
                            guard error == nil else {self.delegate?.didFinishLogin(withError: NSLocalizedString("googleAuthError", comment: "An error occurred in google authentication")); return }
                            guard let authentication = authentication else {self.delegate?.didFinishLogin(withError: NSLocalizedString("googleAuthError", comment: "An error occurred in google authentication")); return }

                            if let idToken = authentication.idToken {
                                let taskManager = TaskManager(urlString: AppConstant.googleLoginURL, method: .POST, parameters: ["gToken": idToken])
                                taskManager.execute { result, content, data in
                                    LoginCredential.parseAndDelegate(self.delegate, result: result, content: content, data: data)
                                }
                            } else {
                                self.delegate?.didFinishLogin(withError: NSLocalizedString("googleTokenError", comment: "An error occurred in google authentication"))
                            }
                                
                        }
                    }
                )
    }
    
}
