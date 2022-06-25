//
//  iPadMainView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 07/06/22.
//

import SwiftUI

struct iPadMainView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    
    init(){
        UITableView.appearance().backgroundColor = UIColor(named: "BackgroundColor")?.withAlphaComponent(0.6) // background color of list
        UINavigationBar.appearance().tintColor = UIColor(named: "PrimaryLabel")!
    }
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            NavigationView{
                ZStack{
                    Color("BackgroundColor").ignoresSafeArea()
                    VStack{
                        Text("myAPTracker").foregroundColor(Color("PrimaryLabel"))
                        List{
                            ForEach(0 ..< MainViewModel.tabs.count, id:\.self) { index in
                                NavigationLink{
                                    switch MainViewModel.tabs[index].tag {
                                    case 0:
                                        HomeView(mainViewModel: viewModel).navigationTitle(MainViewModel.tabs[index].tabName)
                                    case 1:
                                        TrackedView(showLogin: $viewModel.showLogin).navigationTitle(MainViewModel.tabs[index].tabName)
                                    case 2:
                                        ExploreView().navigationTitle(MainViewModel.tabs[index].tabName)
                                    case 3:
                                        SettingView(showLogin: $viewModel.showLogin).navigationTitle(MainViewModel.tabs[index].tabName)
                                    default:
                                        EmptyView()
                                    }
                                } label: {
                                    HStack{
                                        Image(systemName: MainViewModel.tabs[index].iconSystemName)
                                        Text(MainViewModel.tabs[index].tabName)
                                    }
                                    
                                }
                            }
                        }.listStyle(.sidebar).foregroundColor(Color("PrimaryLabel"))
                    }
                }
                }
        }.sheet(isPresented: $viewModel.showLogin) {
            LoginView($viewModel.showLogin).padding()
        }
    }
}

