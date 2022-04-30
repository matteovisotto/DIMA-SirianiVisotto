//
//  ProductViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    let menuItems:[MenuBarItem] = [MenuBarItem(tag: "price", title: "Price", icon: Image(systemName: "creditcard.fill")), MenuBarItem(tag: "detail", title: "Detail", icon: Image(systemName: "text.justify")), MenuBarItem(tag: "comment", title: "Comments", icon: Image(systemName: "message.fill"))]
    
    @Published var selectedTab: String = "price"
    @Published var product: Product
    @Published var productPrices: [Double] = []
    @Published var comments: ProductComments? = nil
    
    @Published var newCommentText: String = ""
    
    init(product: Product){
        self.product = product
        if let ps = product.prices {
            self.product.price = ps.last?.price
        }
        loadData()
    }
    
    func loadData() {
        loadPrices()
        loadComments()
    }
    
    private func loadPrices() {
        let taskManager = TaskManager(urlString: AppConstant.getPriceURL+"?productId=\(product.id)", method: .GET, parameters: nil)
        taskManager.execute { result, content, data in
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
    
}
