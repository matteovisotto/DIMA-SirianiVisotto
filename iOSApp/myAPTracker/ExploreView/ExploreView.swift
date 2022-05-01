//
//  ExploreView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct ExploreView: View {
    @ObservedObject var viewModel: ExploreViewModel = ExploreViewModel()
    
    let columns = [
            GridItem(.flexible()),
            //GridItem(.flexible()),
        ]
    
    var body: some View {
        ZStack{
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
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

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
