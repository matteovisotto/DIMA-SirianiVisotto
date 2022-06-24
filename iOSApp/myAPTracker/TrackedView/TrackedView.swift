//
//  TrackedView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct TrackedView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: TrackedViewModel
    
    init(showLogin: Binding<Bool>){
        self.viewModel = TrackedViewModel(showLogin: showLogin)
    }
    
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
                        Image("login-image").resizable().scaledToFit().frame(width: g.size.width-40, height: g.size.width-40)
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
                            GeometryReader{ geometry in
                                ScrollView(.vertical, showsIndicators: false){
                                    if viewModel.trackingObjects.count > 0{
                                        if(viewModel.isSearching){
                                            if viewModel.searchingObjects.count > 0 {
                                                VStack(spacing: 10) {
                                                    ForEach(0 ..< viewModel.searchingObjects.count, id: \.self){ contentIndex in
                                                        NavigationLink{
                                                            ProductView(product: Product.fromTracked(viewModel.searchingObjects[contentIndex]))
                                                        } label: {
                                                            VStack{
                                                                SingleProductView(Product.fromTracked(viewModel.searchingObjects[contentIndex])).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel")).foregroundColor(Color("PrimaryLabel"))
                                                                Divider().padding(.leading, 10)
                                                            }
                                                        }
                                                        
                                                    }
                                                }
                                            } else {
                                                Text("No results").frame(maxWidth: .infinity, maxHeight: .infinity).accessibilityIdentifier("TrackedViewNoResult")
                                            }
                                        } else {
                                            VStack(spacing: 10) {
                                                ForEach(0 ..< viewModel.trackingObjects.count, id: \.self){ contentIndex in
                                                    NavigationLink{
                                                        ProductView(product: Product.fromTracked(viewModel.trackingObjects[contentIndex]))
                                                    } label: {
                                                        VStack{
                                                            SingleProductView(Product.fromTracked(viewModel.trackingObjects[contentIndex])).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                                            Divider().padding(.leading, 10)
                                                        }
                                                    }
                                                    
                                                }
                                            }
                                        }
                                    } else {
                                        Text("No tracked product").frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(Color("PrimaryLabel"))
                                    }
                                }.onAppear(perform: viewModel.loadData)
                            }
                    }.padding()
                    if(viewModel.isLoading){
                        LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                    }
                }
            }
        }
    }
}

struct TrackedContentView: View {
    var data: [TrackedProduct]
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 10) {
                ForEach(0 ..< data.count, id: \.self){ contentIndex in
                    NavigationLink{
                        ProductView(product: Product.fromTracked(data[contentIndex]))
                    } label: {
                        VStack{
                            SingleProductView(Product.fromTracked(data[contentIndex])).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                            Divider().padding(.leading, 10)
                        }
                    }
                    
                }
            }
        }
        
    }
    
}

struct TrackedView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedView(showLogin: .constant(false)).environmentObject(AppState.shared)
    }
}
