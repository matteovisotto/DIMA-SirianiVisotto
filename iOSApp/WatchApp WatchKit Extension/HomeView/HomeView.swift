//
//  HomeView.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appModel: WatchAppModel
    
    var body: some View {
        NavigationView{
            List{
                if(appModel.isLoading){
                    ProgressView()
                }
                if(appModel.userStatus){
                    NavigationLink{
                        TrackedView().navigationTitle("Tracked")
                    } label: {
                        Text("Tracked")
                    }
                }
                NavigationLink{
                    TopTenView().navigationTitle("Top 10")
                } label: {
                    Text("Top 10")
                }
                NavigationLink{
                    MostTrackedView().navigationTitle("Most tracked")
                } label: {
                    Text("Most tracked")
                }
            }
        }
        .navigationTitle("Home")
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
