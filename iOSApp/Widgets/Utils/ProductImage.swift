//
//  ProductImage.swift
//  WidgetsExtension
//
//  Created by Matteo Visotto on 22/05/22.
//

import Foundation
import SwiftUI

struct ProductImage: View {

  private let url: URL?
    
    init(_ url: String){
        self.url = URL(string: url)
    }

  var body: some View {

    Group {
     if let url = url, let imageData = try? Data(contentsOf: url),
       let uiImage = UIImage(data: imageData) {

       Image(uiImage: uiImage)
         .resizable()
         .aspectRatio(contentMode: .fit)
      }
      else {
       Image("placeholder-image")
      }
    }
  }

}
