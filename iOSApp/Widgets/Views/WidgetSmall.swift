//
//  WidgetSmall.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 08/05/22.
//

import SwiftUI
import WidgetKit

struct WidgetSmall: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            if(entry.products.count > 0){
                VStack{
                    HStack{
                        ProductImage(entry.products.first!.images.first ?? "").background(Color.white).cornerRadius(10)
                        Text("\(entry.products.first!.price ?? 0, specifier: "%.2f") €")
                            .foregroundColor(Color("PrimaryLabel"))
                    }
                    WidgetChart(prices: entry.products.first!.prices ?? [])
                }.padding()
            } else {
                Text("Loading...").foregroundColor(Color("LabelColor"))
            }
        }.widgetURL(URL(string: "aptracker://product?id=\(entry.products.first!.id)")!)
    }
}

struct WidgetSmall_Previews: PreviewProvider {
    static var previews: some View {
        myAPTrackerWidgetView(entry: WidgetModel(date: Date(), products: [WidgetProduct(id: 0, name: "Test Product", shortName: "Test Product", highestPrice: 10, lowestPrice: 9, images: [])]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
