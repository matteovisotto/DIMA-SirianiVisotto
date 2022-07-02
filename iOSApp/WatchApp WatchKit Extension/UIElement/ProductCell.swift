//
//  ProductView.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import SwiftUI

struct ProductCell: View {
    var product: Product
    
    var body: some View {
        VStack{
            Text(product.shortName).lineLimit(2)
            HStack{
                Text("\(product.price ?? 0, specifier: "%.2f") €")
                if(product.priceDrop == 0){
                    Image(systemName: "minus").foregroundColor(Color.orange)
                } else if (product.priceDrop > 0) {
                    Image(systemName: "arrow.up").foregroundColor(Color.red)
                } else {
                    Image(systemName: "arrow.down").foregroundColor(Color.green)
                }
            }
        }
    }
}


