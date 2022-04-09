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
    @Published var isAProduct:Bool = false
    
    var isShown: Binding<Bool>
    
    init(isShown: Binding<Bool>) {
        self.isShown = isShown
    }
    
    func addTracking() -> Void {
        
    }
    
    func addProduct() -> Void {
        
    }
    
}
