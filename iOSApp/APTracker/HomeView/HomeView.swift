//
//  HomeView.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                   
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack{
                            ForEach(0..<100){ index in
                                NavigationLink {
                                    Text("Ciao")
                                } label: {
                                    VStack(alignment: .leading, spacing: 0){
                                        Text("This is the tile").font(.title2)
                                        ZStack{
                                            Image("test").resizable().frame(width: geometry.size.width-20, height: 200)
                                            VStack{
                                                Spacer()
                                                ZStack{
                                                    Color.white.opacity(0.6)
                                                        .frame(width: geometry.size.width-20, height: 50)
                                                    Text("200€").foregroundColor(.black).bold()
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }.padding(.horizontal, 10)
                HStack{
                    Text("Sezione 2").font(.title)
                    Spacer()
                }.padding(.horizontal)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(0..<100){ index in
                        Rectangle().frame(width: ((geometry.size.width)-30)/2, height: 120)
                    }
                }.padding(.horizontal, 10)
            }
            
        }
    }
}

struct HomeViewPreview_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
