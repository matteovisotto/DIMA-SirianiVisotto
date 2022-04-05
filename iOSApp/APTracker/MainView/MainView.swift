//
//  MainView.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    
    @State var showLogin: Bool = false
    
    var body: some View {
        VStack{
            Text(appState.isUserLoggedIn ? "Logged" : "Unlogged")
            
            if(appState.isUserLoggedIn){
                Button{
                    appState.logout()
                } label: {
                    Text("Logout")
                }
            } else {
                Button{
                    showLogin.toggle()
                } label: {
                    Text("Login")
                }
            }
        }
        .viewBackground(Color("BackgroundColor"))
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showLogin) {
            LoginView($showLogin)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
