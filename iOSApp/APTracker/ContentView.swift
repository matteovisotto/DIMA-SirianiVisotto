//
//  ContentView.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI
import FacebookCore
import FacebookLogin
import GoogleSignIn

struct ContentView: View {
    var body: some View {
        LoginView()
       /* Button{
            let loginManager = LoginManager()
            
            loginManager.logIn(permissions: ["public_profile", "email"], viewController: nil) { loginResult in
                        switch loginResult {
                        case .failed(let error):
                            print(error)
                        case .cancelled:
                            print("User cancelled login.")
                        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                            if let token = AccessToken.current {
                                print(token.tokenString)
                            }
                            
                        }
                    }
                
        } label: {
            Text("Facebook")
        }
        
        */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
