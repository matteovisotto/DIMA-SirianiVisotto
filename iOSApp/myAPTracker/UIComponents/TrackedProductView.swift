//
//  TrackedProductView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI

struct TrackedProductView: View {
    
    @ObservedObject var imageLoader: ImageLoader = ImageLoader()
    @State var image: UIImage = UIImage()
    @State var product: TrackedProduct
    @State var sub: Double = 0
    @State var percentage: Double = 0

    init(_ p: TrackedProduct) {
        self.product = p
        if let imgUrl = p.images.first {
            imageLoader.getImage(urlString: imgUrl)
        }
    }
    
    var body: some View{
        GeometryReader{ geometry in
            VStack(alignment: .leading){
                //Text(product.shortName).lineLimit(2).font(.system(size: 16).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel")).padding(.bottom, 5)
                ZStack(alignment: .leading){
                    Color.white
                    Image(uiImage: image).resizable().scaledToFit().onReceive(imageLoader.didChange) { data in
                        self.image = UIImage(data: data) ?? UIImage()
                    }.padding(.leading).padding(.top).padding(.bottom)
                    HStack{
                        Spacer()
                        VStack {
                            /*ZStack (alignment: .trailing){
                                PriceCard().fill(Color("Primary").opacity(0.6)).frame(width: geometry.size.width/3, height: 50).padding(.trailing)
                                Text("\(product.price ?? 0, specifier: "%.2f") €").foregroundColor(Color("PrimaryLabel")).font(.system(size: 16).bold()).padding(.trailing, 30)
                             if (product.prices?.count == 1 || product.prices?.count == 0){
                                 Image(systemName: "minus").foregroundColor(.orange).scaleEffect(2.5).padding(.trailing, 6 * geometry.size.width / 11)
                             } else if(product.prices?[(product.prices?.count ?? 2) - 2].price ?? 0 > product.prices?[(product.prices?.count ?? 1) - 1].price ?? 0){
                                 Image(systemName: "arrow.down").foregroundColor(.green).scaleEffect(2.5).rotationEffect(Angle(degrees: -45)).padding(.trailing, 6 * geometry.size.width / 11)
                             } else if(product.prices?[(product.prices?.count ?? 2) - 2].price ?? 0 < product.prices?[(product.prices?.count ?? 1) - 1].price ?? 0) {
                                 Image(systemName: "arrow.up").foregroundColor(.green).scaleEffect(2.5).rotationEffect(Angle(degrees: 45)).padding(.trailing, 6 * geometry.size.width / 11)
                             } else {
                                 Image(systemName: "minus").foregroundColor(.orange).scaleEffect(2.5).padding(.trailing, 6 * geometry.size.width / 11)
                             }
                                Circle().fill(.white).frame(height: 15).padding(.leading, 100)
                            }*/
                            /*ZStack (alignment: .center){
                                PriceCard().fill(Color("Primary").opacity(0.6)).frame(width: geometry.size.width/3, height: 50)
                                Text("\(product.price ?? 0, specifier: "%.2f") €").foregroundColor(Color("PrimaryLabel")).font(.system(size: 16).bold()).padding(.leading, 30)
                                if (product.prices?.count == 1 || product.prices?.count == 0){
                                    Image(systemName: "minus").foregroundColor(.orange).scaleEffect(2.5).padding(.leading, 8 * geometry.size.width / 11)
                                } else if(product.prices?[(product.prices?.count ?? 2) - 2].price ?? 0 > product.prices?[(product.prices?.count ?? 1) - 1].price ?? 0){
                                    Image(systemName: "arrow.down").foregroundColor(.green).scaleEffect(2.5).rotationEffect(Angle(degrees: -45)).padding(.leading, 8 * geometry.size.width / 11)
                                } else if(product.prices?[(product.prices?.count ?? 2) - 2].price ?? 0 < product.prices?[(product.prices?.count ?? 1) - 1].price ?? 0) {
                                    Image(systemName: "arrow.up").foregroundColor(.green).scaleEffect(2.5).rotationEffect(Angle(degrees: 45)).padding(.leading, 8 * geometry.size.width / 11)
                                } else {
                                    Image(systemName: "minus").foregroundColor(.orange).scaleEffect(2.5).padding(.leading, 8 * geometry.size.width / 11)
                                }
                                Circle().fill(.white).frame(height: 15).padding(.trailing, 90)
                            }*/
                            /*ZStack{
                                PriceCard().fill(Color("Primary").opacity(0.6)).frame(width: geometry.size.width/3, height: 50)
                                Text("\(product.price ?? 0, specifier: "%.2f") €").foregroundColor(Color("PrimaryLabel")).font(.system(size: 16).bold()).padding(.leading)
                                //Circle().fill(.white).frame(width: 100, height: 15).padding(.leading)
                            }*/
                            ZStack (alignment: .center){
                                Text(product.shortName).lineLimit(2).font(.system(size: 16).bold()).multilineTextAlignment(.leading).foregroundColor(.black).padding(.bottom, geometry.size.height / 2).padding(.leading,(10 * geometry.size.width/27)).accessibilityIdentifier("HomeViewProductLastProductAdded")
                                PriceCard().fill(Color("Primary").opacity(0.6)).frame(width: geometry.size.width/3, height: 50).padding(.top, geometry.size.height / 3).padding(.leading,60)
                                Text("\(product.price ?? 0, specifier: "%.2f") €").foregroundColor(Color("PrimaryLabel")).font(.system(size: 16).bold()).padding(.leading, 70).padding(.top, geometry.size.height / 3)
                                if (product.prices?.count ?? 0 < 2){
                                    Image(systemName: "minus").foregroundColor(.orange).scaleEffect(2.5).padding(.leading, 8 * geometry.size.width / 11).padding(.top, 2 * geometry.size.height / 9)
                                    Text("\(percentage, specifier: "%.2f") %").font(.system(size: 16).bold()).foregroundColor(.orange).padding(.leading, 33 * geometry.size.width / 44).padding(.top, 9 * geometry.size.height / 16)
                                } else if(product.prices?[(product.prices?.count ?? 2) - 2].price ?? 0 > product.prices?[(product.prices?.count ?? 1) - 1].price ?? 0){
                                    Image(systemName: "arrow.down").foregroundColor(.green).scaleEffect(2.5).rotationEffect(Angle(degrees: -45)).padding(.leading, 8 * geometry.size.width / 11).padding(.top, geometry.size.height / 6)
                                    Text("\(percentage, specifier: "%.2f") %").font(.system(size: 16).bold()).foregroundColor(.green).padding(.leading, 33 * geometry.size.width / 44).padding(.top, 9 * geometry.size.height / 16)
                                } else if(product.prices?[(product.prices?.count ?? 2) - 2].price ?? 0 < product.prices?[(product.prices?.count ?? 1) - 1].price ?? 0) {
                                    Image(systemName: "arrow.up").foregroundColor(.red).scaleEffect(2.5).rotationEffect(Angle(degrees: 45)).padding(.leading, 8 * geometry.size.width / 11).padding(.top, geometry.size.height / 6)
                                    Text("\(percentage, specifier: "%.2f") %").font(.system(size: 16).bold()).foregroundColor(.red).padding(.leading, 33 * geometry.size.width / 44).padding(.top, 9 * geometry.size.height / 16)
                                } else {
                                    Image(systemName: "minus").foregroundColor(.orange).scaleEffect(2.5).padding(.leading, 8 * geometry.size.width / 11).padding(.top, 2 * geometry.size.height / 9)
                                    Text("\(percentage, specifier: "%.2f") %").font(.system(size: 16).bold()).foregroundColor(.orange).padding(.leading, 33 * geometry.size.width / 44).padding(.top, 9 * geometry.size.height / 16)
                                }
                                
                                Circle().fill(.white).frame(height: 15).padding(.trailing, 90).padding(.top, geometry.size.height / 3).padding(.leading,60)
                            }
                        }.padding(10)
                    }
                }.cornerRadius(10)
            }
        }.onAppear(perform: {
            loadPrices(productId: product.id)
        })
    }
    
    private func getPrices(prices: [Price]) -> [Double] {
        var pricesinDouble: [Double] = []
        for x in prices {
            pricesinDouble.append(x.price)
        }
        return pricesinDouble
    }
    
    private func loadPrices(productId: Int) {
        let taskManager = TaskManager(urlString: AppConstant.getPriceURL+"?productId=\(productId)", method: .GET, parameters: nil)
        taskManager.execute { result, content, data in
            if(result){
                do {
                    let decoder = JSONDecoder()
                    let pricesObj = try decoder.decode(PriceServerResponse.self, from: data!)
                    var p: [Double] = []
                    for x in pricesObj.prices {
                        p.append(x.price)
                    }
                    DispatchQueue.main.async {
                        self.product.prices = pricesObj.prices
                        if(pricesObj.prices.count>0){
                            self.product.price = pricesObj.prices[pricesObj.prices.count-1].price
                        }
                        if (pricesObj.prices.count == 0 || pricesObj.prices.count == 1){
                            self.sub = 0
                            self.percentage = 0
                        } else {
                            self.sub = (product.prices?[(product.prices?.count ?? 1) - 1].price ?? 0) - (product.prices?[(product.prices?.count ?? 2) - 2].price ?? 0)
                            self.percentage = sub / (product.prices?[(product.prices?.count ?? 1) - 1].price ?? 1)
                            if (self.percentage < 0){
                                self.percentage = self.percentage * -1
                            }
                        }
                        //print("first " + "\(self.product.prices?[0].updatedAt)")
                        //print("last" + "\(self.product.prices?[(self.product.prices?.count ?? 0)-1].updatedAt)")
                        //print("lastUpdate" + "\(self.product.lastUpdate)")
                        //print("price" + "\(self.product.price)")
                    }
                } catch {
                    var errorStr = NSLocalizedString("Unable to parse the received content", comment: "Unable to convert data")
                    do {
                        let error = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                        if let e = error {
                            if let d = e["exception"] as? String {
                                errorStr = d
                            }
                        }
                    } catch {}
                    DispatchQueue.main.async {
                        AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: errorStr)
                    }
                }
            }
        }
            
    }
}

/*struct PriceUpOrDown: View{
    var price: Double
    var icon: Image
    var imageColor: Color
    var sale: String
    
    init(price: Double, previous: Double) {
        self.sale = "\((price - previous) / price) %"
        self.price = price
        if(previous > price){
            self.icon = Image(systemName: "arrow.down").scaleEffect(2.5).rotationEffect(Angle(degrees: -45)) as! Image
            self.imageColor = Color.green
        } else if(previous < price) {
            self.icon = Image(systemName: "arrow.up").scaleEffect(2.5).rotationEffect(Angle(degrees: 45)) as! Image
            self.imageColor = Color.red
        } else {
            self.icon = Image(systemName: "minus").scaleEffect(2.5) as! Image
            self.imageColor = Color.orange
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            icon.foregroundColor(imageColor)
            Text(sale).font(.title3.bold())
        }
    }
}*/

struct PriceUpOrDown: View{
    var icon: Image
    var imageColor: Color
    
    init(price: Double, previous: Double) {
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
        icon.foregroundColor(imageColor)
    }
}

struct PriceCard: Shape {
    func path(in rect: CGRect) -> Path {
    
        /*var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX-20, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX+15, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX-20, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path*/
        
        var path = Path()
        
        //Se si tolgono arc e move
        
        //path.move(to: CGPoint(x: rect.minX + 20 - rect.midY, y: rect.midY))
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: (rect.maxY + rect.midY) / 2))
        path.addLine(to: CGPoint(x: rect.minX + 20, y: rect.maxY))
        //path.addArc(center: CGPoint(x: rect.minX + 20, y: rect.midY), radius: rect.midY, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90), clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + 20, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: (rect.minY + rect.midY) / 2))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        //path.addArc(center: CGPoint(x: rect.minX + 20, y: rect.midY), radius: rect.midY, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        return path
    }
}

struct TrackedProductView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            TrackedProductView(TrackedProduct(id: 1, name: "A not very long name for this product", shortName: "A not very long name for this product", description: "", link: "", highestPrice: 12.20, lowestPrice: 9.99, createdAt: "", lastUpdate: "", trackingSince: "", dropKey: "", dropValue: 0, images: ["https://m.media-amazon.com/images/I/71KroddqZCL._AC_SL1500_.jpg"], price: 1000, category: "Test cat")).frame(width: .infinity, height: 200, alignment: .center).padding()
        }
    }
}
