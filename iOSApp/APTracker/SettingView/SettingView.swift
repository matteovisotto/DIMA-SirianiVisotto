//
//  SettingView.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: SettingViewModel
    
    init(showLogin: Binding<Bool>) {
        UITableView.appearance().backgroundColor = .clear
        
        self.viewModel = SettingViewModel(showLogin: showLogin)
    }
    
    var body: some View {
        VStack{
            List{
                //Display User info
                Section{
                    if(appState.isUserLoggedIn){
                        NavigationLink {
                            UserProfileView()
                        } label: {
                            UserCell(userIdentity: appState.userIdentity)
                        }
                    } else {
                        Button{
                            viewModel.showLogin.wrappedValue.toggle()
                        } label: {
                           LoginCell()
                        }
                    }

                }.listRowBackground(Color.clear)
                
                //Other content
                Section(header: Text("General")){
                    NavigationLink {
                        Text("A test")
                    } label: {
                        Text("Test")
                    }

                }.listRowBackground(Color("SecondaryBackgroundColor"))
                //Login and logout button
                if(appState.isUserLoggedIn) {
                    Section {
                        Button{
                            appState.logout()
                        } label: {
                            Text("Logout").foregroundColor(Color.red)
                        }
                    }.listRowBackground(Color("SecondaryBackgroundColor"))
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        SettingView(showLogin: .constant(false)).environmentObject(AppState.shared)
    }
}
