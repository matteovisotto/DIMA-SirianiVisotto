//
//  SingleProductView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI

struct SingleProductView: View {
    
    @ObservedObject var imageLoader: ImageLoader = ImageLoader()
    @State var product: Product

    init(_ p: Product) {
        self.product = p
    }
    
    var body: some View{
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 0){
                HStack(alignment: .center){
                    ProductImage(product.images.first ?? "").background(Color.white).cornerRadius(10)
                    Spacer().frame(width: 10)
                    VStack(spacing: 8){
                        Text(product.shortName).font(.title3).lineLimit(2)
                        HStack{
                            Spacer()
                        Text("\(product.price ?? 0, specifier: "%.2f") €").font(.title2.bold())
                        }
                    }
            }
            }.padding()//.background(Color.white)
        }
    }
}

