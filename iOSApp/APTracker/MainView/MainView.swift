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
            Button{
                appState.riseError(title: "Error", message: "This is an error message used as an example to show it")
            } label: {
                Text("Display error")
            }
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
        MainView().environmentObject(AppState.shared)
    }
}
