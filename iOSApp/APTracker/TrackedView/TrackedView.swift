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
    
    let columns = [
            GridItem(.flexible()),
            //GridItem(.flexible()),
        ]
    
    var body: some View {
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
                        }
                    }.frame(width: g.size.width, height: g.size.height, alignment: .center)
                }
            } else {
                ZStack{
                        GeometryReader{ geometry in
                            ScrollView(.vertical, showsIndicators: false){
                                VStack(spacing: 10) {
                                    ForEach(0 ..< viewModel.trackingObjects.count, id: \.self){ index in
                                        NavigationLink{
                                            ProductView(product: Product.fromTracked(viewModel.trackingObjects[index]))
                                        } label: {
                                            TrackedProductView(viewModel.trackingObjects[index]).frame(width: ((geometry.size.width)-30), height: 120).border(Color.red)
                                        }
                                        
                                    }
                                }.padding(.horizontal, 10)
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

struct TrackedView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedView(showLogin: .constant(false)).environmentObject(AppState.shared)
    }
}
