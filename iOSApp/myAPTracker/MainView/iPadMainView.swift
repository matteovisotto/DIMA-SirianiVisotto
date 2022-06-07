//
//  iPadMainView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 07/06/22.
//

import SwiftUI

struct iPadMainView: View {
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            NavigationView{
                List{
                    NavigationLink{
                        Text("A")
                    } label: {
                        Text("Link A")
                    }
                    NavigationLink{
                        Text("B")
                    } label: {
                        Text("Link B")
                    }
                }.listStyle(.sidebar)
            }
        }
    }
}

