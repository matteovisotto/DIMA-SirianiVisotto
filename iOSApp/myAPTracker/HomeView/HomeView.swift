//
//  HomeView.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import Foundation
import SwiftUI
import SwiftfulLoadingIndicators

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: HomeViewModel

    init() {
        self.viewModel = HomeViewModel()
    }
    
    let columns = [
            GridItem(.flexible()),
            //GridItem(.flexible()),
        ]
    var body: some View {
        ZStack{
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .leading, spacing: 10){
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    ForEach(0..<viewModel.trackingObjects.count, id: \.self){ index in
                                        NavigationLink {
                                            ProductView(product: Product.fromTracked(viewModel.trackingObjects[index]))
                                        } label: {
                                            TrackedProductView(viewModel.trackingObjects[index]).frame(width: geometry.size.width-20, height: 200)
                                        }
                                    }
                                }
                            }
                        }.padding(.horizontal, 10)
                        HStack{
                            Text("Sezione 2").font(.title)
                            Spacer()
                        }.padding(.horizontal)
                        VStack(spacing: 10) {
                            ForEach(0 ..< viewModel.mostTracked.count, id: \.self){ index in
                                NavigationLink{
                                    ProductView(product: viewModel.mostTracked[index])
                                } label: {
                                    SingleProductView(viewModel.mostTracked[index]).frame(width: ((geometry.size.width)-30), height: 120).border(Color.red)
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




struct HomeViewPreview_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
