//
//  SingleProductView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI

struct SingleProductView: View {
    
    @ObservedObject var imageLoader: ImageLoader = ImageLoader()
    @State var image: UIImage = UIImage()
    @State var product: Product

    init(_ p: Product) {
        self.product = p
        if let imgUrl = p.images.first {
            imageLoader.getImage(urlString: imgUrl)
        }
    }
    
    var body: some View{
        GeometryReader{ geometry in
            HStack(alignment: .center){
                Image(uiImage: image).resizable().scaledToFit().frame(width: 80, height: 80).onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage() }
                Spacer().frame(width: 10)
                VStack(spacing: 8){
                    Text(product.name).font(.title3).lineLimit(2)
                    HStack{
                        Spacer()
                    Text("\(product.price ?? 0, specifier: "%.2f") €").font(.title2.bold())
                    }
                }
            }.padding()
        }
    }
}

