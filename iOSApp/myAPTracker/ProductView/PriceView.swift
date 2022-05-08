//
//  ProductChart.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import SwiftUI
//import LineChartView
import SwiftUICharts

struct PriceView: View {
    
    @ObservedObject var viewModel: ProductViewModel
    var chartStyle = ChartStyle(backgroundColor: Color("BackgroundColor"), accentColor: Color.blue, gradientColor: GradientColor(start: Color.red, end: Color.red), textColor: Color("LabelColor"), legendTextColor: Color("LabelColor"), dropShadowColor: Color("BackgroundColor"))
    var chartDarkStyle = ChartStyle(backgroundColor: Color("BackgroundColor"), accentColor: Color.blue, gradientColor: GradientColor(start: Color.orange, end: Color.orange), textColor: Color("LabelColor"), legendTextColor: Color("LabelColor"), dropShadowColor: Color("BackgroundColor"))
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        chartStyle.darkModeStyle = chartDarkStyle
    }
    
    var body: some View {
        VStack{
            HLPriceView(lowestPrice: viewModel.product.lowestPrice, highestPrice: viewModel.product.highestPrice).padding(.horizontal)
            //La size è definita da una CGSize quindi si può gestire bene
            LineChartView(data: viewModel.productPrices, title: "Trend", style: chartStyle, form: ChartForm.extraLarge, dropShadow: false, valueSpecifier: "%.2f")
            /*LineChart()
                .data(viewModel.productPrices)
                .chartStyle(ChartStyle(backgroundColor: Color("BackgroundColor"),
                                       foregroundColor: ColorGradient(.blue, .accentColor)))
                .frame(height: 200)*/
            //LineChartView(lineChartParameters: LineChartParameters(data: viewModel.productPrices)).frame(height: 160)
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 2){
                    ForEach(0..<(viewModel.product.prices?.count ?? 0), id: \.self){index in
                        if(index == 0) {
                            PriceCell(price: viewModel.product.prices![index].price, date: viewModel.product.prices![index].updatedAt, previous: viewModel.product.prices![index].price, isFirst: true).padding(.horizontal)
                        } else {
                            PriceCell(price: viewModel.product.prices![index].price, date: viewModel.product.prices![index].updatedAt, previous: viewModel.product.prices![index-1].price).padding(.horizontal).padding(.vertical, 2.5)
                        }
                    }
                }.frame(maxWidth: .infinity)
            }.frame(maxWidth: .infinity)
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
