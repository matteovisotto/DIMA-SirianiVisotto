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
    @Environment(\.presentationMode) var presentationMode
    
    init(){
        UITableView.appearance().backgroundColor = UIColor(named: "BackgroundColor")?.withAlphaComponent(0.6) // background color of list
        UINavigationBar.appearance().tintColor = UIColor(named: "PrimaryLabel")!
        UINavigationBar.appearance().barTintColor = UIColor(named: "BackgroundColor")!
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryLabel")!]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryLabel")!]
    }
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            NavigationView{
                ZStack{
                    Color("BackgroundColor").ignoresSafeArea()
                    VStack{
                        List{
                            ForEach(0 ..< MainViewModel.tabs.count, id:\.self) { index in
                                NavigationLink{
                                    ZStack{
                                        Color("BackgroundColor").ignoresSafeArea()
                                        switch MainViewModel.tabs[index].tag {
                                        case 0:
                                            iPadHomeView(mainViewModel: viewModel).navigationTitle(MainViewModel.tabs[index].tabName)
                                        case 1:
                                            iPadTrackedView(showLogin: $viewModel.showLogin).navigationTitle(MainViewModel.tabs[index].tabName)
                                        case 2:
                                            iPadExploreView().navigationTitle(MainViewModel.tabs[index].tabName)
                                        case 3:
                                            iPadSettingView(showLogin: $viewModel.showLogin).navigationTitle(MainViewModel.tabs[index].tabName)
                                        default:
                                            EmptyView()
                                        }
                                    }
                                } label: {
                                    HStack{
                                        Image(systemName: MainViewModel.tabs[index].iconSystemName)
                                        Text(MainViewModel.tabs[index].tabName)
                                    }
                                    
                                }
                            }
                        }.listStyle(.sidebar).foregroundColor(Color("PrimaryLabel"))
                        Spacer()
                        Button{
                            
                        } label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Add product")
                            }
                        }
                    }
                
                }.navigationTitle("myAPTracker")
                   
                ZStack{
                    Color("BackgroundColor").ignoresSafeArea()
                    iPadHomeView(mainViewModel: viewModel).navigationTitle(MainViewModel.tabs[0].tabName)
                }
                }
        }.sheet(isPresented: $viewModel.showLogin) {
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                LoginView($viewModel.showLogin).padding()
            }
        }
    }
}

