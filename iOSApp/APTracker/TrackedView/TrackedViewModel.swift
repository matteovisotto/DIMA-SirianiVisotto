//
//  TrackedViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import Foundation
import SwiftUI

class TrackedViewModel: ObservableObject {
    
    var showLogin: Binding<Bool>
    @Published var trackingObjects: [TrackedProduct] = []
    @Published var searchingObjects: [TrackedProduct] = []
    
    @Published var isLoading: Bool = false
    
    @Published var isSearching: Bool = false
    @Published var searchText: String = ""
    
    init(showLogin: Binding<Bool>){
        self.showLogin = showLogin
        loadData()
    }
    
    func displayLogin() {
        self.showLogin.wrappedValue = true
    }
    
    private func loadMyTracking() {
        let task = TaskManager(urlString: AppConstant.getMyTrackingURL+"?lastPriceOnly", method: .GET, parameters: nil)
        task.executeWithAccessToken { result, content, data in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([TrackedProduct].self, from: data!)
                    DispatchQueue.main.async {
                        self.trackingObjects = identity
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
        self.isLoading = true
        if(AppState.shared.isUserLoggedIn){
            self.loadMyTracking()
        }
    }
    
    func performSearch() {
        self.searchingObjects.removeAll()
        DispatchQueue.main.async {
            self.searchingObjects = self.trackingObjects.filter { obj in
                obj.name.range(of: self.searchText, options: .caseInsensitive) != nil
            }
        }
        
    }
}
