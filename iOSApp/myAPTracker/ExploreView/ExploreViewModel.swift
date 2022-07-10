//
//  ExploreViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import Foundation
import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var mostTracked: [Product] = []
    @Published var biggestPercentageDrop: [DropPriceProduct] = []
    @Published var biggestRangeDrop: [DropPriceProduct] = []
    @Published var loading1: Bool = false
    @Published var loading2: Bool = false
    @Published var loading3: Bool = false
    
    init(){
        loadData()
    }
    
    private func loadAllProduct() -> Void {
        let task = TaskManager(urlString: AppConstant.getMostTracked+"?limit=10", method: .GET, parameters: nil)
        task.execute { result, content, data in
            DispatchQueue.main.async {
                self.loading1 = false
            }
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([Product].self, from: data!)
                    DispatchQueue.main.async {
                        self.mostTracked = identity
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
            } else {
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unknown error", comment: "Unknown error"))
                }
                
            }
        }
    }
    
    private func loadAllProductLastPriceDropPercentage() -> Void {
        let task = TaskManager(urlString: AppConstant.getLastPriceDropPercentage+"?limit=10", method: .GET, parameters: nil)
        task.execute { result, content, data in
            DispatchQueue.main.async {
                self.loading2 = false
            }
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([DropPriceProduct].self, from: data!)
                    DispatchQueue.main.async {
                        self.biggestPercentageDrop = identity
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
            } else {
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unknown error", comment: "Unknown error"))
                }
                
            }
        }
    }
    
    private func loadAllPriceDrop() -> Void {
        let task = TaskManager(urlString: AppConstant.getPriceDrop+"?limit=10", method: .GET, parameters: nil)
        task.execute { result, content, data in
            DispatchQueue.main.async {
                self.loading3 = false
            }
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([DropPriceProduct].self, from: data!)
                    DispatchQueue.main.async {
                        self.biggestRangeDrop = identity
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
            } else {
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unknown error", comment: "Unknown error"))
                }
                
            }
        }
    }
    
    func loadData() {
        self.loading1 = true
        self.loading2 = true
        self.loading3 = true
        self.loadAllProduct()
        self.loadAllProductLastPriceDropPercentage()
        self.loadAllPriceDrop()
    }
}
