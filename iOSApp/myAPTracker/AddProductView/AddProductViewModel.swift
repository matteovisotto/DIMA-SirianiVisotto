//
//  AddProductViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 09/04/22.
//

import Foundation
import SwiftUI

class AddProductViewModel: ObservableObject {
    
    @Published var currentUrl: String = "https://amazon.it"
    @Published var shouldGoBack: Bool = false
    @Published var shouldGoForward: Bool = false
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var shouldReloadWithGivenUrl: Bool = false
    @Published var isWebViewLoading: Bool = false
    @Published var isAProduct: Bool = false
    @Published var dropValue: Double = 0.0;
    @Published var dropKey: String = "none";
    
    @Published var showLoader: Bool = false
    
    var isShown: Binding<Bool>
    
    init(isShown: Binding<Bool>) {
        self.isShown = isShown
    }
    
    func addTracking() -> Void {
        self.showLoader = true
        let parameters: [String: Any] = [
            "amazonUrl": self.currentUrl,
            "dropValue": "\(PreferenceManager.shared.getDropValue())",
            "dropKey": PreferenceManager.shared.getDropKey(),
        ]
        let taskManager = TaskManager(urlString: AppConstant.addTrackingByUrlURL, method: .POST, parameters: parameters)
        taskManager.executeWithAccessToken(accessToken: AppState.shared.userCredential?.accessToken ?? "") { result, content, data in
            self.handleResult(result, content, data)
        }
    }
    
    func addProduct() -> Void {
        self.showLoader = true
        let parameters: [String: Any] = [
            "amazonUrl": self.currentUrl,
        ]
        let taskManager = TaskManager(urlString: AppConstant.addProductURL, method: .POST, parameters: parameters)
        taskManager.execute { result, content, data in
            self.handleResult(result, content, data)
        }
    }
    
    func handleResult(_ result: Bool, _ content: String?, _ data: Data?) -> Void {
        DispatchQueue.main.async{
            self.showLoader = false
        }
        if(result){
                var message = NSLocalizedString("Unable to parse the received content", comment: "Unable to convert data")
                do {
                    let c = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    if let e = c {
                        if let d = e["exception"] as? String {
                            message = d
                        }
                        if let _ = e["success"] as? String {
                            DispatchQueue.main.async{
                                FeedbackAlert.present(text: NSLocalizedString("Success", comment: "Success"), icon: UIImage(systemName: "checkmark")!){
                                }
                            }
                            return
                        }
                    }
                } catch {}
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: message)
                }
            } else {
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unexpected error occurred", comment: "Unexpected error occurred"))
                }
            }
    }
}
