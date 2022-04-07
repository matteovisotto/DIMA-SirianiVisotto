//
//  MainHeader.swift
//  APTracker
//
//  Created by Matteo Visotto on 07/04/22.
//

import Foundation
import SwiftUI

struct MainHeader: View {
    @EnvironmentObject var appState: AppState
    var tabName: String
    var body: some View{
        VStack{
            if(appState.isUserLoggedIn){
                 HStack{
                     Text("Welcome back " + (appState.userIdentity?.name ?? "")).font(.footnote)
                    Spacer()
                 }
            }
            HStack{
                Text(tabName).font(.largeTitle.bold()).foregroundColor(Color("PrimaryLabel"))
                Spacer()
            }
        }
        
        
    }
}



