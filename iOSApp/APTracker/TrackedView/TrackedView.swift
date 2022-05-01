//
//  TrackedView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI

struct TrackedView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: TrackedViewModel
    
    init(showLogin: Binding<Bool>){
        self.viewModel = TrackedViewModel(showLogin: showLogin)
    }
    
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
                EmptyView()
            }
        }
    }
}

struct TrackedView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedView(showLogin: .constant(false)).environmentObject(AppState.shared)
    }
}
