//
//  HomeViewModel.swift
//  APTracker
//
//  Created by Tia on 14/04/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var trackingObjects: [TrackingObject] = []
    
    init() {
    }
    
    func loadMyTracking() {
        let task = TaskManager(urlString: AppConstant.getMyTrackingURL+"?lastPriceOnly", method: .GET, parameters: nil)
        task.executeWithAccessToken { result, content, data in
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([TrackingObject].self, from: data!)
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
}
