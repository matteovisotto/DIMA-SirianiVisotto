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
    
    init(showLogin: Binding<Bool>){
        self.showLogin = showLogin
    }
    
    func displayLogin() {
        self.showLogin.wrappedValue = true
    }
    
}
