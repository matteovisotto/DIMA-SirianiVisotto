//
//  TrackedView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct iPadTrackedView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: TrackedViewModel
    
    init(showLogin: Binding<Bool>){
        self.viewModel = TrackedViewModel(showLogin: showLogin)
    }
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        let searchTextProxy = Binding<String>(get: {
                    viewModel.searchText
                }, set: {
                    viewModel.searchText = $0
                    if($0 == ""){
                        viewModel.isSearching = false
                    } else {
                        viewModel.isSearching = true
                        viewModel.performSearch()
                    }
                })
        
        ZStack{
            Color("BackgroundColor").ignoresSafeArea(.all)
            if(!appState.isUserLoggedIn){
                GeometryReader{ g in
                    VStack(spacing: 10){
                        Image("login-image").resizable().scaledToFit().frame(width: min(g.size.width, g.size.height)*2/3, height:  min(g.size.width, g.size.height)*2/3)
                        Text("You have to be logged in to display this page").bold().foregroundColor(Color("PrimaryLabel"))
                        Button {
                            viewModel.displayLogin()
                        } label: {
                            Text("Login Now").bold().foregroundColor(Color("Primary"))
                        }.accessibilityIdentifier("TrackedViewLoginButton")
                    }.frame(width: g.size.width, height: g.size.height, alignment: .center)
                }
            } else {
                ZStack{
                    
                            GeometryReader{ geometry in
                                ScrollView(.vertical, showsIndicators: false){
                                    VStack{
                                        HStack{
                                            Image(systemName: "magnifyingglass")
                                            TextField("Search", text: searchTextProxy).accessibilityIdentifier("TrackedViewSearchTextField")
                                            if(viewModel.isSearching){
                                                Button{
                                                    viewModel.searchText = ""
                                                    viewModel.isSearching = false
                                                } label: {
                                                    Image(systemName: "multiply")
                                                }
                                            }
                                        }.padding(.horizontal)
                                            .padding(.vertical, 5)
                                            .background(Color("BackgroundColorInverse").opacity(0.2)).foregroundColor(Color("PrimaryLabel"))
                                            .cornerRadius(10)
                                        if viewModel.trackingObjects.count > 0{
                                            if(viewModel.isSearching){
                                                if viewModel.searchingObjects.count > 0 {
                                                    LazyVGrid(columns: columns, spacing: 20) {
                                                        ForEach(0 ..< viewModel.searchingObjects.count, id: \.self){ contentIndex in
                                                            NavigationLink{
                                                                iPadProductView(product: Product.fromTracked(viewModel.searchingObjects[contentIndex]))
                                                            } label: {
                                                                VStack{
                                                                    SingleProductView(Product.fromTracked(viewModel.searchingObjects[contentIndex])).frame(width: ((geometry.size.width/2)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel")).foregroundColor(Color("PrimaryLabel"))
                                                                    Divider().padding(.leading, 10)
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                } else {
                                                    Text("No results").frame(maxWidth: .infinity, maxHeight: .infinity).accessibilityIdentifier("TrackedViewNoResult")
                                                }
                                            } else {
                                                LazyVGrid(columns: columns, spacing: 20) {
                                                    ForEach(0 ..< viewModel.trackingObjects.count, id: \.self){ contentIndex in
                                                        NavigationLink{
                                                            iPadProductView(product: Product.fromTracked(viewModel.trackingObjects[contentIndex]))
                                                        } label: {
                                                            VStack{
                                                                SingleProductView(Product.fromTracked(viewModel.trackingObjects[contentIndex])).frame(width: ((geometry.size.width/2)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                                                Divider().padding(.leading, 10)
                                                            }
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                        } else {
                                            Text("No tracked product").frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(Color("PrimaryLabel"))
                                        }
                                    }.padding()
                                }.onAppear(perform: viewModel.loadData)
                            }
                    if(viewModel.isLoading){
                        LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                    }
                }
            }
        }
    }
}

