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
                        }.accessibilityIdentifier("UserProfileNavigationLink")
                    } else {
                        Button{
                            viewModel.showLogin.wrappedValue.toggle()
                        } label: {
                           LoginCell()
                        }
                    }

                }.listRowBackground(Color.clear)
                
                if(appState.isUserLoggedIn){
                    Section(header: Text("Tracking")){
                        NavigationLink {
                            TrackingSettingView()
                        } label: {
                            Text("Product notification")
                        }.accessibilityIdentifier("ProductNotification")

                    }.listRowBackground(Color("SecondaryBackgroundColor"))
                }
                
                Section(header: Text("Notification"), footer: Text("With disabled notification you cannot receive any updated about your tracked product and also general information. Click above to change your notification settings.")){
                    Button{
                        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                            UIApplication.shared.open(appSettings)
                        }
                    }label: {
                        HStack{
                            Circle().fill(appState.areNotificationsEnabled ? Color.green : Color.red).frame(width: 10, height: 10)
                            VStack(alignment: .leading, spacing: 0){
                                Text("Open notification settings")
                                (appState.areNotificationsEnabled ? Text("Notification are enabled") : Text("Notification are disabled")).font(.caption)
                            }.foregroundColor(Color("PrimaryLabel"))
                        }
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
            }.listStyle(.insetGrouped)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        SettingView(showLogin: .constant(false)).environmentObject(AppState.shared)
    }
}
