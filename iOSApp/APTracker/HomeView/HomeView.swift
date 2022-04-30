//
//  HomeView.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: HomeViewModel

    init() {
        self.viewModel = HomeViewModel()
    }
    
    let columns = [
            GridItem(.flexible()),
            //GridItem(.flexible()),
        ]
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 10){
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(0..<viewModel.trackingObjects.count, id: \.self){ index in
                                NavigationLink {
                                    ProductView(product: Product.fromTracked(viewModel.trackingObjects[index]))
                                } label: {
                                    TrackedProduct(viewModel.trackingObjects[index]).frame(width: geometry.size.width-20, height: 200)
                                }
                            }
                        }
                    }
                }.padding(.horizontal, 10)
                HStack{
                    Text("Sezione 2").font(.title)
                    Spacer()
                }.padding(.horizontal)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(0 ..< viewModel.mostTracked.count, id: \.self){ index in
                        NavigationLink{
                            ProductView(product: viewModel.mostTracked[index])
                        } label: {
                            SingleProductView(viewModel.mostTracked[index]).frame(width: ((geometry.size.width)-30), height: 120).border(Color.red)
                        }
                        
                    }
                }.padding(.horizontal, 10)
            }.onAppear(perform: viewModel.loadData)
    }
    
}
}

struct TrackedProduct: View {
    
    @ObservedObject var imageLoader:ImageLoader = ImageLoader()
    @State var image:UIImage = UIImage()
    @State var product: TrackingObject

    init(_ p: TrackingObject) {
        self.product = p
        if let imgUrl = p.images.first {
            imageLoader.getImage(urlString: imgUrl)
        }
    }
    
    var body: some View{
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 0){
                Text(product.name).font(.title2)
                ZStack{
                    Image(uiImage: image).resizable().scaledToFit().onReceive(imageLoader.didChange) { data in
                        self.image = UIImage(data: data) ?? UIImage()
                }
                    VStack{
                        Spacer()
                        ZStack{
                            Color.white.opacity(0.6)
                                .frame(height: 50)
                            Text("\(product.price ?? 0, specifier: "%.2f") €").foregroundColor(.black).bold()
                        }
                        
                    }
                }
            }
        }
    }
}

struct SingleProductView: View {
    
    @ObservedObject var imageLoader:ImageLoader = ImageLoader()
    @State var image:UIImage = UIImage()
    @State var product: Product

    init(_ p: Product) {
        self.product = p
        if let imgUrl = p.images.first {
            imageLoader.getImage(urlString: imgUrl)
        }
    }
    
    var body: some View{
        GeometryReader{ geometry in
            HStack(alignment: .center){
                Image(uiImage: image).resizable().scaledToFit().frame(width: 80, height: 80).onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage() }
                Spacer().frame(width: 10)
                VStack(spacing: 8){
                    Text(product.name).font(.title3).lineLimit(2)
                    HStack{
                        Spacer()
                    Text("\(product.price ?? 0, specifier: "%.2f") €").font(.title2.bold())
                    }
                }
            }.padding()
        }
    }
}

struct HomeViewPreview_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
