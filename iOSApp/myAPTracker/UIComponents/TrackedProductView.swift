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
            VStack(alignment: .leading){
                Text(product.shortName).lineLimit(2).font(.system(size: 16).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel")).padding(.bottom, 5)
                ZStack(alignment: .leading){
                    Color.white
                    Image(uiImage: image).resizable().scaledToFit().onReceive(imageLoader.didChange) { data in
                        self.image = UIImage(data: data) ?? UIImage()
                    }.padding()
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            ZStack{
                                PriceCard().fill(Color("Primary").opacity(0.6)).frame(width: geometry.size.width/3, height: 50)
                                Text("\(product.price ?? 0, specifier: "%.2f") €").foregroundColor(Color("PrimaryLabel")).font(.system(size: 16).bold()).padding()
                            }.padding(10)
                        }
                    }
                }.cornerRadius(10)
            }
            /*VStack(alignment: .leading, spacing: 0){
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
            }*/
        }
    }
}

struct PriceCard: Shape {
    func path(in rect: CGRect) -> Path {
    
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX-20, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX+15, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX-20, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct TrackedProductView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            TrackedProductView(TrackedProduct(id: 1, name: "A not very long name for this product", shortName: "A not very long name for this product", description: "", link: "", highestPrice: 12.20, lowestPrice: 9.99, createdAt: "", lastUpdate: "", trackingSince: "", dropKey: "", dropValue: 0, images: ["https://m.media-amazon.com/images/I/71KroddqZCL._AC_SL1500_.jpg"], price: 1000)).frame(width: .infinity, height: 200, alignment: .center).padding()
        }
    }
}
