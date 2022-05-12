//
//  TrackingSettingViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import Foundation
import SwiftUI

class TrackingSettingViewModel: ObservableObject {
    @Published var dropKey: String = "always"
    @Published var dropValue: String = "0"
    @Published var dropValuePercentage: String = "0"
    @Published var commentPolicy: String = "never"
    
    private var dropValueVal: Double = 0
    
    init(){
        loadData()
    }
    
    func loadData() {
        dropKey = PreferenceManager.shared.getDropKey()
        if (dropKey == "percentage"){
            dropValuePercentage = "\(PreferenceManager.shared.getDropValue())"
            dropValue = "0.0"
        } else if (dropKey == "value") {
            dropValue = "\(PreferenceManager.shared.getDropValue())"
            dropValuePercentage = "0.0"
        }
        //dropValue = "\(PreferenceManager.shared.getDropValue())"
        commentPolicy = PreferenceManager.shared.getCommentPolicy()
    }
    
    func saveSetting(percentage: Bool) -> Void {
        if(dropKey == "none" || dropKey == "always"){
           dropValueVal = 0
        } else {
            if (percentage){
                if let v = Double(dropValuePercentage.replacingOccurrences(of: ",", with: ".")){
                    dropValueVal = v
                } else {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Invalid value", comment: "invalid value"))
                    return
                }
            } else {
                if let v = Double(dropValue.replacingOccurrences(of: ",", with: ".")){
                    dropValueVal = v
                } else {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Invalid value", comment: "invalid value"))
                    return
                }
            }
        }
        PreferenceManager.shared.setDropKey(dropKey)
        PreferenceManager.shared.setDropValue(dropValueVal)
        PreferenceManager.shared.setCommentPolicy(commentPolicy)
        FeedbackAlert.present(text: NSLocalizedString("Success", comment: "Success"), icon: UIImage(systemName: "checkmark")!){
        }
    }
    
    func validateSettings() -> Bool {
        if(dropKey != "none" && dropKey != "always"){
            if (dropKey == "percentage") {
                return dropValuePercentage != "0" && dropValuePercentage != "0.0"
            } else {
                return dropValue != "0" && dropValue != "0.0"
            }
        }
        return true
    }
}
