//
//  TrackedProductView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI

struct TrackedProductView: View {
    
    @ObservedObject var imageLoader:ImageLoader = ImageLoader()
    @State var image:UIImage = UIImage()
    @State var product: TrackedProduct

    init(_ p: TrackedProduct) {
        self.product = p
        if let imgUrl = p.images.first {
            imageLoader.getImage(urlString: imgUrl)
        }
    }
    
    var body: some View{
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 0){
                Text(product.shortName).font(.system(size: 20).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel")).padding(.bottom, 5)
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


