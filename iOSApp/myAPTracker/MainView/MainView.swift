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
                        .padding(.horizontal).accessibilityIdentifier("SelectedTabTitleName")
                    
                    //TabView(selection: $viewModel.selectedTab){
                    switch viewModel.selectedTab {
                    case 0:
                        HomeView(mainViewModel: self.viewModel)
                    case 1:
                        TrackedView(showLogin: $viewModel.showLogin)
                    case 2:
                        ExploreView()
                    case 3:
                        SettingView(showLogin: $viewModel.showLogin)
                    default:
                        EmptyView()
                    }
                        /*HomeView(mainViewModel: self.viewModel).gesture(DragGesture()).tag(0)
                        TrackedView(showLogin: $viewModel.showLogin).tag(1).gesture(DragGesture())
                        ExploreView().tag(2).gesture(DragGesture())
                        SettingView(showLogin: $viewModel.showLogin).tag(3).gesture(DragGesture())*/
                    //}
                    //.tabViewStyle(.page(indexDisplayMode: .never))
                  
                    
                    AppTabBar(selectedTab: $viewModel.selectedTab, elements: MainViewModel.tabs, centralButtonAction: {
                        viewModel.showAddProduct.toggle()
                    })
                            .frame(height: 33)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                            .background(Color("SecondaryBackgroundColor"))
        
                    
                }
            }.navigationBarHidden(true)
                
           
        }.fullScreenCover(isPresented: $viewModel.showLogin) {
            LoginView($viewModel.showLogin)
        }
        .sheet(isPresented: $viewModel.showAddProduct) {
            AddProductView(isShown: $viewModel.showAddProduct)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppState.shared)
    }
}
