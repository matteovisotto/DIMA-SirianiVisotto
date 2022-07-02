//
//  TrackedView.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import SwiftUI

struct TrackedView: View {
    @ObservedObject var viewModel: TrackedViewModel = TrackedViewModel()
    
    var body: some View {
        ZStack{
            if(viewModel.isLoading){
                ProgressView()
            } else{
                if(viewModel.errorString != nil){
                    Text(viewModel.errorString!).accessibilityIdentifier("TopTenViewTopTenWatch")
                } else {
                    List{
                        ForEach(0..<viewModel.products.count, id: \.self){index in
                            NavigationLink{
                                ProductView(product: viewModel.products[index])
                            } label: {
                                ProductCell(product: viewModel.products[index])
                            }
                        }
                    }
                }
            }
        }
    }
}

struct TrackedView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedView()
    }
}
