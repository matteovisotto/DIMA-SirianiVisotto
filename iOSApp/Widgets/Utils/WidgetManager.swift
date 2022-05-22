//
//  WidgetManager.swift
//  WidgetsExtension
//
//  Created by Matteo Visotto on 22/05/22.
//

import Foundation


class WidgetManager {
    
    static func getFakeData() -> [WidgetProduct]{
        return []
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
