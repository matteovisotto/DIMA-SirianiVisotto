//
//  ProductViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    let menuItems:[MenuBarItem] = [MenuBarItem(tag: "price", title: "Price", icon: Image(systemName: "creditcard.fill")), MenuBarItem(tag: "detail", title: "Detail", icon: Image(systemName: "text.justify")), MenuBarItem(tag: "comment", title: "Comments", icon: Image(systemName: "message.fill"))]
    
    @Published var selectedTab: String = "price"
    @Published var product: Product
    @Published var productPrices: [Double] = []
    
    init(product: Product){
        self.product = product
        if let ps = product.prices {
            self.product.price = ps.last?.price
        }
    }
    
    func loadData() {
        loadPrices()
    }
    
    private func loadPrices() {
        let taskManager = TaskManager(urlString: AppConstant.getPriceURL+"?productId=\(product.id)", method: .GET, parameters: nil)
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
                        self.productPrices = p
                        if(pricesObj.prices.count>0){
                            self.product.price = pricesObj.prices[pricesObj.prices.count-1].price
                        }
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
