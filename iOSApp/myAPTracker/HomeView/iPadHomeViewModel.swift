//
//  iPadHomeViewModel.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 30/06/22.
//

import Foundation
import UIKit

class iPadHomeViewModel: HomeViewModel {
    
    @Published var categories: [String] = []
    
    override init() {
        super.init()
        loadCategories()
    }
    
    private func loadCategories() {
        let taskManager = TaskManager(urlString: AppConstant.getCategories, method: .GET, parameters: nil)
        taskManager.execute { result, content, data in
            if(result){
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Categories.self, from: data!)
                    DispatchQueue.main.async {
                        self.categories = response.categories
                    }
                } catch {
                }
            }
        }
    }
}
