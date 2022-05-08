//
//  ImageViewer.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 08/05/22.
//

import SwiftUI


struct ImageViewer: View {
    @ObservedObject var viewModel: ImageViewerViewModel
    
    init(isPresented: Binding<Bool>, imageUrls: [String], currentImage: Binding<Int>) {
        self.viewModel = ImageViewerViewModel(isPresented: isPresented, imageUrls: imageUrls, currentImage: currentImage)
    }
    
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Button{
                        viewModel.dismiss()
                    } label: {
                        Image(systemName: "multiply").foregroundColor(Color("LightLabel"))
                    }.frame(width: 15, height: 15)
                }.padding()
                TabView(selection: viewModel.currentImage){
                    ForEach(0 ..< viewModel.imageUrls.count, id: \.self) {index in
                        ProductImage(viewModel.imageUrls[index].replacingOccurrences(of: "SR320,320", with: "UL1500"), loading: viewModel.loadImage).tag(index)
                    }
                }.tabViewStyle(.page).frame(maxWidth: .infinity, maxHeight: .infinity).padding(.bottom, 15)
            }
        }
    }
}

