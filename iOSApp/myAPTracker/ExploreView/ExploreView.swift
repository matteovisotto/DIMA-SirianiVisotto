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
    
    var body: some View {
        ZStack{
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 10) {
                            ForEach(0 ..< viewModel.mostTracked.count, id: \.self){ contentIndex in
                                NavigationLink{
                                    ProductView(product: viewModel.mostTracked[contentIndex])
                                } label: {
                                    VStack{
                                        SingleProductView(viewModel.mostTracked[contentIndex]).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                        Divider().padding(.leading, 10)
                                    }
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
