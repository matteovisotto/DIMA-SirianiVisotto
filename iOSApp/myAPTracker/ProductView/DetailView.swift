//
//  DetailView.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            TabView(selection: $viewModel.currentImage){
                ForEach(0..<viewModel.product.images.count, id: \.self) {index in
                    ProductImage(viewModel.product.images[index]).onTapGesture {
                        viewModel.displayImageView = true
                    }.tag(index)

                }
            }.tabViewStyle(.page)
                .frame(height: 150)
        ScrollView{
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.product.name).font(.body.bold()).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("DetailViewName")
                Text(viewModel.product.category.uppercased()).font(.caption).foregroundColor(Color("Primary")).accessibilityIdentifier("DetailViewCategory")
                Divider().foregroundColor(Color("PrimaryLabel"))
                Text(viewModel.product.description.replacingOccurrences(of: "\\n", with: "\n")).font(.body).lineLimit(nil).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("DetailViewDescription")
            }
        }
            
        }.frame(maxWidth: .infinity)
            .fullScreenCover(isPresented: $viewModel.displayImageView) {
                ImageViewer(isPresented: $viewModel.displayImageView, imageUrls: viewModel.product.images, currentImage: $viewModel.currentImage)
            }
    }
}



