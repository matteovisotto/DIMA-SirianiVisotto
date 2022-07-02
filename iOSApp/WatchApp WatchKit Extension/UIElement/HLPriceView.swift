//
//  HLPriceView.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import SwiftUI


struct HLPriceView: View {
    var lowestPrice: Double
    var highestPrice: Double
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5){
            HStack{
                Image(systemName: "arrow.up").foregroundColor(Color.red).font(.body.bold())
                Text("\(highestPrice, specifier: "%.2f") €").accessibilityIdentifier("ProductViewHighestPrice")
                Spacer()
            }
            HStack{
                Image(systemName: "arrow.down").foregroundColor(Color.green).font(.body.bold())
                Text("\(lowestPrice, specifier: "%.2f") €").accessibilityIdentifier("ProductViewLowestPrice")
                Spacer()
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}
