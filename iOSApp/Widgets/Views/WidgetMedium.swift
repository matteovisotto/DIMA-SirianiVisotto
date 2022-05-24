//
//  WidgetMedium.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 08/05/22.
//

import SwiftUI

struct WidgetMedium: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            if(entry.products.count > 0){
                GeometryReader{ geometry in
                    Link(destination: URL(string: "aptracker://product?id=\(entry.products.first!.id)")!) {
                        VStack(alignment: .leading, spacing: 0){
                            HStack(alignment: .center){
                                ProductImage(entry.products.first!.images.first ?? "").background(Color.white).cornerRadius(10)
                                Spacer().frame(width: 10)
                                VStack(spacing: 8){
                                    Text(entry.products.first!.shortName).lineLimit(2).font(.system(size: 16).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel"))
                                }
                            }
                            HStack{
                                Text("\(entry.products.first!.price ?? 0, specifier: "%.2f") €").font(.title2.bold()).foregroundColor(Color("PrimaryLabel"))
                                
                                WidgetChart(prices: entry.products.first!.prices ?? [])
                            }
                        }.padding()
                    }
                }
            } else {
                Text("Loading...")
            }
        }
    }
}
