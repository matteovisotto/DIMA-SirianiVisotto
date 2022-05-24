//
//  WidgetLarge.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 08/05/22.
//

import SwiftUI

struct WidgetLarge: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            if(entry.products.count > 0){
                VStack{
                    ForEach(0..<entry.products.count, id: \.self){ index in
                        if(index != 0){
                            Divider()
                        }
                        Link(destination: URL(string: "aptracker://product?id=\(entry.products[index].id)")!) {
                            VStack(alignment: .leading, spacing: 0){
                                HStack(alignment: .center){
                                    ProductImage(entry.products[index].images.first ?? "").background(Color.white).cornerRadius(10)
                                    Spacer().frame(width: 10)
                                    VStack(spacing: 8){
                                        Text(entry.products[index].shortName).lineLimit(2).font(.system(size: 16).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel"))
                                    }
                                }
                                HStack{
                                    Text("\(entry.products[index].price ?? 0, specifier: "%.2f") €").font(.system(size: 18).bold()).foregroundColor(Color("PrimaryLabel"))
                                    
                                    WidgetChart(prices: entry.products[index].prices ?? [])
                                }
                            }
                        }
                    }
                }.padding()
            } else {
                Text("Loading...").foregroundColor(Color("LabelColor"))
            }
        }
    }
}
