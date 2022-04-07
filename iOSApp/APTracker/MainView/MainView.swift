//
//  MainView.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    
    @State var showLogin: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                VStack{
                    Spacer()
                    Color("SecondaryBackgroundColor").frame(height: UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                }.ignoresSafeArea()
                VStack {
                    MainHeader(tabName: MainViewModel.tabs[viewModel.selectedTab].tabName)
                        .frame(height: appState.isUserLoggedIn ? 60 : 50)
                        .padding(.horizontal)
                    
                    TabView(selection: $viewModel.selectedTab){
                        Color("BackgroundColor").tag(0)
                        Color.blue.tag(1)
                        Color.yellow.tag(2)
                        if (appState.isUserLoggedIn) {
                            Button{appState.logout()}label:{Text("Logout")}.tag(3)
                        } else {
                            Button{showLogin.toggle()}label:{Text("Login")}.tag(3)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    AppTabBar(selectedTab: $viewModel.selectedTab, elements: MainViewModel.tabs, centralButtonAction: {})
                            .frame(height: 33)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                            .background(Color("SecondaryBackgroundColor"))
        
                    
                }
            }.navigationBarHidden(true)
                
           
        }.fullScreenCover(isPresented: $showLogin) {
            LoginView($showLogin)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppState.shared)
    }
}
