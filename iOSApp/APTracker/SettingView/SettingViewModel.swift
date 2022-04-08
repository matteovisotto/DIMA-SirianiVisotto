//
//  SettingViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    @Published var showLogin: Binding<Bool>
    
    init(showLogin: Binding<Bool>) {
        self.showLogin = showLogin
    }
    
}
