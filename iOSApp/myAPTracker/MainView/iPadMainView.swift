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
                    NavigationLink(isActive: .constant(true)) {
                        ZStack{
                            Color("BackgroundColor").ignoresSafeArea()
                            switch viewModel.selectedTab {
                            case 0:
                                iPadHomeView(mainViewModel: viewModel).navigationTitle(MainViewModel.tabs[0].tabName)
                            case 1:
                                iPadTrackedView(showLogin: $viewModel.showLogin).navigationTitle(MainViewModel.tabs[1].tabName)
                            case 2:
                                iPadExploreView().navigationTitle(MainViewModel.tabs[2].tabName)
                            case 3:
                                iPadSettingView(showLogin: $viewModel.showLogin).navigationTitle(MainViewModel.tabs[3].tabName)
                            default:
                                EmptyView()
                            }
                        }
                    } label: {
                        EmptyView()
                    }


                    VStack{
                        List{
                            Group{
                            ForEach(0 ..< MainViewModel.tabs.count, id:\.self) { index in
                                Button{
                                    viewModel.selectedTab = MainViewModel.tabs[index].tag
                                } label: {
                                    HStack{
                                        Image(systemName: MainViewModel.tabs[index].iconSystemName)
                                        Text(MainViewModel.tabs[index].tabName)
                                    }.foregroundColor(viewModel.selectedTab == MainViewModel.tabs[index].tag ? Color("Primary") : Color("PrimaryLabel"))
                                    
                                }.accessibilityIdentifier("iPadMainButton\(index)")
                            }
                            }.listRowBackground(Color.clear)
                        }.listStyle(.sidebar).foregroundColor(Color("PrimaryLabel"))
                        Spacer()
                        Button{
                            viewModel.showAddProduct.toggle()
                        } label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Add product")
                            }.font(.body.bold())
                        }.frame(maxWidth: .infinity).padding(.horizontal).padding(.vertical, 5).background(Color("Primary")).foregroundColor(Color.white).cornerRadius(10).padding()
                            .accessibilityIdentifier("iPadMainViewAddProduct")
                    }
                
                }.navigationTitle("Menu")
                }
        }
        .sheet(isPresented: $viewModel.showAddProduct, content: {
            AddProductView(isShown: $viewModel.showAddProduct)
        })
        .sheet(isPresented: $viewModel.showLogin) {
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                LoginView($viewModel.showLogin).padding()
            }
        }
        
    }
}

