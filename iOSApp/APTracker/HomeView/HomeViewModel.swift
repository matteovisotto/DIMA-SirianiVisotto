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
        /*if (AppState.shared.isUserLoggedIn) {
            self.loadMyTracking();
        }*/
    }
    
    func loadMyTracking() {
        let task = TaskManager(urlString: AppConstant.getMyTrackingURL, method: .GET, parameters: nil)
        task.executeWithAccessToken(accessToken: AppState.shared.userCredential?.accessToken ?? "") { result, content, data in
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([TrackingObject].self, from: data!)
                    self.trackingObjects = identity
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
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: errorStr)
                }
            } else {
                AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unknown error", comment: "Unknown error"))
            }
        }
    }
}
