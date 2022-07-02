//
//  MostTrackedView.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import SwiftUI

struct MostTrackedView: View {
    @ObservedObject var viewModel: MostTrackedViewModel = MostTrackedViewModel()
    
    var body: some View {
        ZStack{
            if(viewModel.isLoading){
                ProgressView()
            } else{
                if(viewModel.errorString != nil){
                    Text(viewModel.errorString!).accessibilityIdentifier("MostTrackedViewTrackedTextWatch")
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

