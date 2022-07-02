//
//  ProductView.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import SwiftUI

struct ProductView: View {
    
    var product: Product
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true){
            VStack(alignment: .leading, spacing: 10){
                
                Text(product.shortName).font(.caption.bold()).frame(maxWidth: .infinity).accessibilityIdentifier("ProductViewNameWatch")
                    Text(product.category.capitalizingFirstLetter()).font(.footnote)
                    HStack(alignment: .center, spacing: 5){
                        Text("Now:")
                        Text("\(product.price ?? 0, specifier: "%.2f") €").font(.title3.bold())
                        Spacer()
                    }.frame(maxWidth: .infinity)
                if(product.priceDrop != 0){
                    HStack(alignment: .center, spacing: 5){
                        Text("\(product.priceDropPercentage , specifier: "%.2f") %").font(.title3.bold())
                        Spacer()
                    }.frame(maxWidth: .infinity)
                }
                    HLPriceView(lowestPrice: product.lowestPrice, highestPrice: product.highestPrice).frame(maxWidth: .infinity)
                
                    TabView{
                        ForEach(0..<product.images.count, id:\.self){index in
                            ProductImage(product.images[index]).frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }.frame(height: 170)
                
            }.padding(5)
        }
    }
}


