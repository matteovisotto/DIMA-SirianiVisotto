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
                    }.padding(.leading).padding(.top).padding(.bottom)
                    HStack{
                        Spacer()
                        VStack{
                            /*LineGraph(data: getPrices(prices: product.prices ?? []), lineWidth: 2, lineColors: [Color("Primary"), Color("PrimaryLabel")], fillGradientColors: [Color("BackgroundColorInverse").opacity(0.3), Color("BackgroundColorInverse").opacity(0.2), Color("BackgroundColorInverse").opacity(0.1)]).frame(width: 5 * geometry.size.width/11, height: geometry.size.height/3)*/
                            LineGraph(data: getPrices(prices: product.prices ?? []), lineWidth: 2, lineColors: correctColor(lastPrice: (product.prices?[(product.prices?.count ?? 1) - 1].price) ?? 0, penultimatePrice: (product.prices?[(product.prices?.count ?? 2) - 2].price) ?? 0, isLineColor: true, pricesCount: product.prices?.count ?? -1), fillGradientColors: correctColor(lastPrice: (product.prices?[(product.prices?.count ?? 1) - 1].price) ?? 0, penultimatePrice: (product.prices?[(product.prices?.count ?? 2) - 2].price) ?? 0, isLineColor: false, pricesCount: product.prices?.count ?? -1)).frame(width: /*5 * geometry.size.width/11*/geometry.size.width/2, height: geometry.size.height/3).padding(.trailing)
                            //Spacer()
                            ZStack{
                                PriceCard().fill(Color("Primary").opacity(0.6)).frame(width: geometry.size.width/3, height: 50)
                                Text("\(product.price ?? 0, specifier: "%.2f") €").foregroundColor(Color("PrimaryLabel")).font(.system(size: 16).bold()).padding()
                            }//.padding(10)
                        }.padding(10)
                    }
                }.cornerRadius(10)
            }
        }.onAppear(perform: {
            loadPrices(productId: product.id)
        })
    }
    
    private func correctColor(lastPrice: Double, penultimatePrice: Double, isLineColor: Bool, pricesCount: Int) -> [Color] {
        if (isLineColor){
            if (pricesCount == -1 || pricesCount == 1 || pricesCount == 0){
                return[Color.orange, Color.orange]
            }
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
            if (pricesCount == -1 || pricesCount == 1 || pricesCount == 0){
                return[Color.orange.opacity(0.3), Color.orange.opacity(0.2), Color.orange.opacity(0.1)]
            }
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
