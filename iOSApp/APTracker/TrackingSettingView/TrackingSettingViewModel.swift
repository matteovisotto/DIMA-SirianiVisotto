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
    
    private var dropValueVal: Double = 0
    
    init(){
        loadData()
    }
    
    func loadData() {
        dropKey = PreferenceManager.shared.getDropKey()
        dropValue = "\(PreferenceManager.shared.getDropValue())"
    }
    
    func saveSetting() -> Void {
        if(dropKey == "none" || dropKey == "always"){
           dropValueVal = 0
        } else {
            if let v = Double(dropValue.replacingOccurrences(of: ",", with: ".")){
                dropValueVal = v
                
            } else {
                AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Invalid value", comment: "invalid value"))
                return
            }
        }
        PreferenceManager.shared.setDropKey(dropKey)
        PreferenceManager.shared.setDropValue(dropValueVal)
        FeedbackAlert.present(text: NSLocalizedString("Success", comment: "Success"), icon: UIImage(systemName: "checkmark")!){
        }
    }
    
    func validateSettings() -> Bool {
        if(dropKey != "none" && dropKey != "always"){
            return dropValue != "0"
        }
        return true
    }
}
