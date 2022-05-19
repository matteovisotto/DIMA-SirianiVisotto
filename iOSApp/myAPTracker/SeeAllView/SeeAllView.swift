//
//  SeeAllView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 19/05/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct SeeAllView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel: SeeAllViewModel
    
    init(apiUrl: String, viewTitle: String){
        viewModel = SeeAllViewModel(apiUrl: apiUrl, viewTitle: viewTitle)
    }
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea(.all)
                GeometryReader{ geometry in
                    VStack{
                        HStack{
                            Button{
                                mode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrow.left").font(.title3.bold())
                            }.foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                        }
                        Spacer().frame(height: 8)
                        HStack{
                            Text(viewModel.viewTitle).font(.largeTitle.bold()).foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                        }
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 10) {
                                ForEach(0 ..< viewModel.products.count, id: \.self){ contentIndex in
                                    NavigationLink{
                                        ProductView(product: viewModel.products[contentIndex])
                                    } label: {
                                        VStack{
                                            SingleProductView(viewModel.products[contentIndex]).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                            Divider().padding(.leading, 10)
                                        }
                                    }
                                    
                                }
                            }.padding(.horizontal, 10)
                        }.onAppear(perform: viewModel.loadData)
                    }
                    .padding(.horizontal,15)
                        .padding(.vertical, 10)
                    
            }
            if(viewModel.isLoading){
                LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
            }
        }.navigationBarHidden(true)
    }
}

/*
struct SeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllView()
    }
}
*/
