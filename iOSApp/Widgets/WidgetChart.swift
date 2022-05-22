//
//  WidgetChart.swift
//  WidgetsExtension
//
//  Created by Matteo Visotto on 22/05/22.
//

import SwiftUI

struct WidgetChart: View {
    var prices: [Double]
    
    init(prices: [Price]){
        self.prices = prices.map{(p) -> Double in
            return p.price
        }
    }
    
    var body: some View {
        LineGraph(data: prices, lineWidth: 2, lineColors: correctColor(prices: prices, isLineColor: true, pricesCount: prices.count), fillGradientColors: correctColor(prices: prices, isLineColor: false, pricesCount: prices.count))
    }
    
    private func correctColor(prices: [Double], isLineColor: Bool, pricesCount: Int) -> [Color] {
        if prices.count == 0 {return [Color.clear]}
        var lastPrice: Double = 0
        var penultimatePrice: Double = 0
        if (isLineColor){
            if (pricesCount == 1 || pricesCount == 0){
                return[Color.orange, Color.orange]
            }
            lastPrice = prices[pricesCount - 1]
            penultimatePrice = prices[pricesCount - 2]
            if (lastPrice < penultimatePrice){
                //Discesa
                return[Color.green, Color.green]
            } else if (lastPrice > penultimatePrice) {
                //Salita
                return[Color.red, Color.red]
            } else {
                return[Color.orange, Color.orange]
            }
        } else {
            if (pricesCount == -1 || pricesCount == 1){
                return[Color.orange.opacity(0.3), Color.orange.opacity(0.2), Color.orange.opacity(0.1)]
            }
            lastPrice = prices[pricesCount - 1]
            penultimatePrice = prices[pricesCount - 2]
            if (lastPrice < penultimatePrice){
                //Discesa
                return[Color.green.opacity(0.3), Color.green.opacity(0.2), Color.green.opacity(0.1)]
            } else if (lastPrice > penultimatePrice) {
                //Salita
                return[Color.red.opacity(0.3), Color.red.opacity(0.2), Color.red.opacity(0.1)]
            } else {
                return[Color.orange.opacity(0.3), Color.orange.opacity(0.2), Color.orange.opacity(0.1)]
            }
        }
    }
}


