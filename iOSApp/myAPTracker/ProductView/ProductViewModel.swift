//
//  ProductViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    var menuItems:[MenuBarItem]
    
    @Published var selectedTab: String = "price"
    @Published var product: Product
    @Published var productPrices: [Double] = []
    @Published var comments: ProductComments? = nil
    @Published var trackedStatus: TrackingStatus? = nil
    
    @Published var newCommentText: String = ""
    
    @Published var priceLoading: Bool = false
    @Published var commentLoading: Bool = false
    @Published var statusLoading: Bool = true
    
    @Published var openSetting: Bool = false
    
    @Published var displayImageView: Bool = false
    @Published var currentImage: Int = 0
    
    init(product: Product, menuItems: [MenuBarItem] = [MenuBarItem(tag: "price", title: "Price", icon: Image(systemName: "creditcard.fill")), MenuBarItem(tag: "detail", title: "Detail", icon: Image(systemName: "text.justify")), MenuBarItem(tag: "comment", title: "Comments", icon: Image(systemName: "message.fill"))], defaultSelection: String = "price"){
        self.product = product
        self.selectedTab = defaultSelection
        self.menuItems = menuItems
        if let ps = product.prices {
            self.product.price = ps.last?.price
        }
        loadData()
    }
    
    func loadData() {
        self.priceLoading = true
        self.commentLoading = true
        loadPrices()
        loadComments()
        if(AppState.shared.isUserLoggedIn){
            self.statusLoading = true
            getTrackedStatus()
        }
    }
    
    private func getTrackedStatus(){
        let taskManager = TaskManager(urlString: AppConstant.getTrackingStatusURL+"?productId=\(product.id)", method: .GET, parameters: nil)
        taskManager.executeWithAccessToken { result, content, data in
            DispatchQueue.main.async {
                self.statusLoading = false
            }
            if(result){
                do {
                    let decoder = JSONDecoder()
                    let trackingStatus = try decoder.decode(TrackingStatus.self, from: data!)
                    DispatchQueue.main.async {
                        self.trackedStatus = trackingStatus
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
    
    private func loadPrices() {
        let taskManager = TaskManager(urlString: AppConstant.getPriceURL+"?productId=\(product.id)", method: .GET, parameters: nil)
        taskManager.execute { result, content, data in
            DispatchQueue.main.async {
                self.priceLoading = false
            }
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
    
    private func loadComments() {
        let taskManager = TaskManager(urlString: AppConstant.getCommentURL+"?productId=\(product.id)", method: .GET, parameters: nil)
        taskManager.execute { result, content, data in
            DispatchQueue.main.async {
                self.commentLoading = false
            }
            if(result){
                do {
                    let decoder = JSONDecoder()
                    let c = try decoder.decode(ProductComments.self, from: data!)
                    DispatchQueue.main.async {
                        self.comments = c
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
    
    func createComment() {
        let param: [String: Any] = [
            "productId": self.product.id,
            "text": self.newCommentText
        ]
        let taskMenager = TaskManager(urlString: AppConstant.addCommentURL, method: .POST, parameters: param)
        taskMenager.executeWithAccessToken { result, content, data in
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
                                        self.newCommentText = ""
                                        self.loadComments()
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
    
    func deleteComment(cId: Int) {
        let param: [String: Any] = [
            "commentId": cId
        ]
        let taskMenager = TaskManager(urlString: AppConstant.removeCommentURL, method: .POST, parameters: param)
        taskMenager.executeWithAccessToken { result, content, data in
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
                                        self.newCommentText = ""
                                        self.loadComments()
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
    
    func updateComment(cId: Int, text: String) {
        let param: [String: Any] = [
            "commentId": cId,
            "text": text
        ]
        let taskMenager = TaskManager(urlString: AppConstant.updateCommentURL, method: .POST, parameters: param)
        taskMenager.executeWithAccessToken { result, content, data in
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
                                        self.newCommentText = ""
                                        self.loadComments()
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
    
    func startTracking() -> Void {
        let parameters: [String: Any] = [
            "id": self.product.id,
            "dropValue": "\(PreferenceManager.shared.getDropValue())",
            "dropKey": PreferenceManager.shared.getDropKey(),
            "commentPolicy": PreferenceManager.shared.getCommentPolicy()
        ]
        let taskManager = TaskManager(urlString: AppConstant.addTrackingByIdURL, method: .POST, parameters: parameters)
        taskManager.executeWithAccessToken(accessToken: AppState.shared.userCredential?.accessToken ?? "") { result, content, data in
            self.handleResult(result, content, data){
                self.getTrackedStatus()
            }
        }
    }
    
    func stopTracking() -> Void {
        let parameters: [String: Any] = [
            "productId": self.product.id,
        ]
        let taskManager = TaskManager(urlString: AppConstant.removeTrackingURL, method: .POST, parameters: parameters)
        taskManager.executeWithAccessToken(accessToken: AppState.shared.userCredential?.accessToken ?? "") { result, content, data in
            self.handleResult(result, content, data) {
                self.getTrackedStatus()
            }
        }
    }
    
    func updateTracking() -> Void {
        let parameters: [String: Any] = [
            "productId": self.product.id,
            "dropValue": "\(self.trackedStatus?.dropValue ?? 0)",
            "dropKey": self.trackedStatus?.dropKey ?? "always",
            "commentPolicy": self.trackedStatus?.commentPolicy ?? "never"
        ]
        let taskManager = TaskManager(urlString: AppConstant.updateTrackingURL, method: .POST, parameters: parameters)
        taskManager.executeWithAccessToken(accessToken: AppState.shared.userCredential?.accessToken ?? "") { result, content, data in
            self.handleResult(result, content, data) {
                self.getTrackedStatus()
            }
        }
    }
    
    
    func handleResult(_ result: Bool, _ content: String?, _ data: Data?, callback: @escaping () -> ()) -> Void {
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
                                    callback()
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

class iPadProductViewModel: ProductViewModel {
    init(product: Product, menuItems: [MenuBarItem] = [MenuBarItem(tag: "detail", title: "Detail", icon: Image(systemName: "text.justify")), MenuBarItem(tag: "comment", title: "Comments", icon: Image(systemName: "message.fill"))]){
        super.init(product: product, menuItems: menuItems, defaultSelection: "detail")
    }
}
