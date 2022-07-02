//
//  TopTenViewModel.swift
//  WatchApp WatchKit Extension
//
//  Created by Matteo Visotto on 02/07/22.
//

import Foundation
import SwiftUI

class TopTenViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorString: String? = nil
    @Published var products: [DropPriceProduct] = []
    
    init() {
        loadData()
    }
    
    private func loadData() -> Void {
        self.isLoading = true
        loadAllProductLastPriceDropPercentage()
    }
    
    private func loadAllProductLastPriceDropPercentage() -> Void {
        let task = TaskManager(urlString: AppConstant.getLastPriceDropPercentage+"?limit=10", method: .GET)
        task.execute { result, content, data in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([DropPriceProduct].self, from: data!)
                    DispatchQueue.main.async {
                        self.products = identity
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
                        self.errorString = errorStr
                    }
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.errorString = NSLocalizedString("Error", comment: "Error")
                }
                
            }
        }
    }
}
