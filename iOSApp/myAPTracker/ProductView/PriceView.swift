//
//  ProductChart.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import SwiftUI
import SwiftfulLoadingIndicators


struct PriceView: View {
    @ObservedObject var viewModel: ProductViewModel

    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack{
        VStack{
            HLPriceView(lowestPrice: viewModel.product.lowestPrice, highestPrice: viewModel.product.highestPrice).padding(.horizontal)
            
            if (viewModel.productPrices.count < 2 && !viewModel.priceLoading){
                Text("Not enough data to display the graph").font(.system(size: 20).bold()).multilineTextAlignment(.center).foregroundColor(Color("PrimaryLabel")).frame(maxWidth: .infinity, alignment: .center).padding()
            } else {
                LineGraph(data: viewModel.productPrices, lineWidth: 2, lineColors: correctColor(prices: viewModel.product.prices ?? [], isLineColor: true, pricesCount: viewModel.productPrices.count), fillGradientColors: correctColor(prices: viewModel.product.prices ?? [], isLineColor: false, pricesCount: viewModel.productPrices.count)).frame(height: 200).padding(.top, 10)
            }
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 2){
                    ForEach((0..<(viewModel.product.prices?.count ?? 0)).reversed(), id: \.self){index in
                        if(index == 0) {
                            PriceCell(price: viewModel.product.prices![index].price, date: viewModel.product.prices![index].updatedAt, previous: viewModel.product.prices![index].price, isFirst: true).padding(.horizontal)
                        } else {
                            PriceCell(price: viewModel.product.prices![index].price, date: viewModel.product.prices![index].updatedAt, previous: viewModel.product.prices![index-1].price).padding(.horizontal).padding(.vertical, 2.5)
                        }
                    }
                }.frame(maxWidth: .infinity)
            }.frame(maxWidth: .infinity)
                
        }
            if(viewModel.priceLoading){
                LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
            }
        }
    }
    
    private func correctColor(prices: [Price], isLineColor: Bool, pricesCount: Int) -> [Color] {
        if prices.count == 0 {return [Color.clear]}
        var lastPrice: Double = 0
        var penultimatePrice: Double = 0
        if (isLineColor){
            if (pricesCount == 1 || pricesCount == 0){
                return[Color.orange, Color.orange]
            }
            lastPrice = prices[pricesCount - 1].price
            penultimatePrice = prices[pricesCount - 2].price
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
            lastPrice = prices[pricesCount - 1].price
            penultimatePrice = prices[pricesCount - 2].price
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

struct PriceCell: View{
    var price: Double
    var date: String
    var icon: Image
    var imageColor: Color
    var isFirst: Bool
    
    init(price: Double, date: String, previous: Double, isFirst: Bool = false) {
        self.isFirst = isFirst
        self.price = price
        self.date = date
        if(previous > price){
            self.icon = Image(systemName: "arrow.down")
            self.imageColor = Color.green
        } else if(previous < price) {
            self.icon = Image(systemName: "arrow.up")
            self.imageColor = Color.red
        } else {
            self.icon = Image(systemName: "minus")
            self.imageColor = Color.orange
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            if(!isFirst){
                Rectangle().fill(Color("PrimaryLabel").opacity(0.6)).frame(height: 1).padding(.bottom, 5)
            }
            HStack{
                VStack(alignment: .leading){
                    Text("\(price, specifier: "%.2f") €").font(.title3.bold())
                    Text(date).font(.caption)
                }.foregroundColor(Color("PrimaryLabel"))
                Spacer()
                icon.foregroundColor(imageColor)
            }
        }
    }
}

struct PriceCell_Previews: PreviewProvider {
    static var previews: some View {
        PriceCell(price: 10, date: "2022-04-21 12:00:04", previous: 9)
    }
}
