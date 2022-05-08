//
//  ImageViewerViewModel.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 08/05/22.
//

import Foundation
import SwiftUI

class ImageViewerViewModel: ObservableObject {
    @Published var imageUrls: [String]
    var currentImage: Binding<Int>
    var isPresented: Binding<Bool>
    
    var loadImage: UIImage = {
        if let img = UIImage(named: "imgload") {
            img.withTintColor(UIColor(named: "LightLabel") ?? UIColor.white)
            return img
        }
        return UIImage(systemName: "multiply")!
    }()
    
    init(isPresented: Binding<Bool>, imageUrls: [String], currentImage: Binding<Int>) {
        self.isPresented = isPresented
        self.imageUrls = imageUrls
        self.currentImage = currentImage
    }
    
    func dismiss() -> Void {
        self.isPresented.wrappedValue = false
    }
}
