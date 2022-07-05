//
//  WidgetManager.swift
//  WidgetsExtension
//
//  Created by Matteo Visotto on 22/05/22.
//

import Foundation


class WidgetManager {
    
    static func getFakeData() -> [WidgetProduct]{
        return [WidgetProduct(id: 0, name: "This beautiful first product", shortName: "First product", highestPrice: 1025.99, lowestPrice: 350.96, images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEYU7gR32xChbBPeVKPBMu2Rsfs0593Lf0Gw&usqp=CAU"], prices: [Price(updatedAt: "", price: 1025.99), Price(updatedAt: "", price: 1025.99), Price(updatedAt: "", price: 350.96), Price(updatedAt: "", price: 350.96)], price: 350.96), WidgetProduct(id: 1, name: "This beautiful second product", shortName: "Second product", highestPrice: 502.10, lowestPrice: 499.99, images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEYU7gR32xChbBPeVKPBMu2Rsfs0593Lf0Gw&usqp=CAU"], prices: [Price(updatedAt: "", price: 499.99), Price(updatedAt: "", price: 502.10), Price(updatedAt: "", price: 502.10), Price(updatedAt: "", price: 499.99)], price: 499.99), WidgetProduct(id: 2, name: "This beautiful third product", shortName: "Third product", highestPrice: 25.49, lowestPrice: 10.0, images: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEYU7gR32xChbBPeVKPBMu2Rsfs0593Lf0Gw&usqp=CAU"], prices: [Price(updatedAt: "", price: 18), Price(updatedAt: "", price: 25.49), Price(updatedAt: "", price: 10), Price(updatedAt: "", price: 15.25)], price: 15.25)]
    }
    
    static func getWidgetType() -> Int {
        return GroupPreferenceManager.shared.getWidgetType()
    }
    
    static func loadData(completion: @escaping ([WidgetProduct]) -> () ) {
        let apiType = GroupPreferenceManager.shared.getApiType()
        var apiUrl = ""
        switch apiType{
        case 0:
            apiUrl = "https://aptracker.matmacsystem.it/api/v1/product/getByLastPriceDropPercentage?limit=3&lastPriceOnly=f"
        default:
            apiUrl = "https://aptracker.matmacsystem.it/api/v1/product/getByLastPriceDropPercentage?limit=3&lastPriceOnly=f"
        }
        
        TaskManager.execute(urlString: apiUrl) { result, content, data in
            if(result){
                do {
                    let decoder = JSONDecoder()
                    let c = try decoder.decode([WidgetProduct].self, from: data!)
                    DispatchQueue.main.async {
                        completion(c)
                    }
                } catch {}
            }
        }
    }
    
}
