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
            TabView{
                ForEach(0..<viewModel.product.images.count, id: \.self) {index in
                    ProductImage(viewModel.product.images[index])
                }
            }.tabViewStyle(.page)
                .frame(height: 150)
        ScrollView{
            Text(viewModel.product.description).font(.body).lineLimit(nil).foregroundColor(Color("PrimaryLabel"))
            }
            
        }.frame(maxWidth: .infinity)
    }
}

struct ProductImage: View {
    
    @ObservedObject var imageLoader:ImageLoader = ImageLoader()
    @State var image:UIImage = UIImage()

    init(_ i: String) {
        imageLoader.getImage(urlString: i)
    }
    
    var body: some View{
        Image(uiImage: image).resizable().scaledToFit().onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

