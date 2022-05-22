//
//  ProductImage.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 22/05/22.
//

import Foundation
import SwiftUI

struct ProductImage: View {
    
    @ObservedObject var imageLoader:ImageLoader = ImageLoader()
    @State var image:UIImage

    init(_ i: String, loading: UIImage = UIImage()) {
        self.image = loading
        imageLoader.getImage(urlString: i)
    }
    
    var body: some View{
        Image(uiImage: image).resizable().scaledToFit().onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
