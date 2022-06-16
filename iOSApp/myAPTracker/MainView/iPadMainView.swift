//
//  iPadMainView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 07/06/22.
//

import SwiftUI

struct iPadMainView: View {
    init(){
        UITableView.appearance().backgroundColor = UIColor(named: "BackgroundColor")?.withAlphaComponent(0.6) // background color of list
       
    }
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            NavigationView{
                List{
                    NavigationLink{
                        ZStack{
                            Color("BackgroundColor").ignoresSafeArea()
                            Text("A")
                        }
                    } label: {
                        Text("Link A")
                    }
                    NavigationLink{
                        Text("B")
                    } label: {
                        Text("Link B")
                    }
                }.listStyle(.sidebar).foregroundColor(Color("PrimaryLabel"))
            }
        }
    }
}

