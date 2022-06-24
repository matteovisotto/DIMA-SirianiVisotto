//
//  SwiftUIView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 03/05/22.
//

import SwiftUI

struct HLPriceView: View {
    var lowestPrice: Double
    var highestPrice: Double
    
    var body: some View {
        HStack{
            Spacer()
            Image(systemName: "arrow.up").foregroundColor(Color.red).font(.body.bold())
            Text("\(highestPrice, specifier: "%.2f") €").accessibilityIdentifier("ProductViewHighestPrice")
            Spacer()
            Image(systemName: "arrow.down").foregroundColor(Color.green).font(.body.bold())
            Text("\(lowestPrice, specifier: "%.2f") €").accessibilityIdentifier("ProductViewLowestPrice")
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct HLPriceView_Previews: PreviewProvider {
    static var previews: some View {
        HLPriceView(lowestPrice: 0.0, highestPrice: 100.0).padding()
    }
}
