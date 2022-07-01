//
//  ContentView.swift
//  watchapp WatchKit Extension
//
//  Created by Matteo Visotto on 01/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WatchAppModel = WatchAppModel()
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink {
                    Text("Top 10")
                } label: {
                    Text("Top 10")
                }
                
                if(viewModel.userStatus){
                    NavigationLink {
                        Text("Link 1")
                    } label: {
                        Text("Link 1")
                    }
                }
            }.navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
