//
//  AddProductView.swift
//  APTracker
//
//  Created by Matteo Visotto on 09/04/22.
//

import SwiftUI

struct AddProductView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: AddProductViewModel

    
    init(isShown: Binding<Bool>){
        self.viewModel = AddProductViewModel(isShown: isShown)
    }
    
    var body: some View {
        ZStack{
            Color("AmazonBackground").ignoresSafeArea()
            VStack{
                HStack{
                    IconTextField(titleKey: "", text: $viewModel.currentUrl, icon: Image(systemName: "link"), foregroundColor: Color("AmazonText"), showValidator: false)
                    Button{
                        viewModel.shouldReloadWithGivenUrl.toggle()
                    } label: {
                        Image(systemName: "arrowtriangle.right")
                    }.disabled(viewModel.isWebViewLoading)
                        .foregroundColor(viewModel.isWebViewLoading ? Color("AmazonText").opacity(0.5) : Color("AmazonText"))
                }.padding()
                WebView(viewModel, stringUrl: "https://amazon.it").textFieldStyle(.roundedBorder)
                HStack{
                    Button{
                        viewModel.shouldGoBack.toggle()
                    } label: {
                        Image(systemName: "chevron.left")
                    }.disabled(!viewModel.canGoBack)
                        .foregroundColor(viewModel.canGoBack ? Color("AmazonText") : Color("AmazonText").opacity(0.5))
                    Spacer()
                    if(appState.isUserLoggedIn){
                        Button{
                            viewModel.addTracking()
                        } label: {
                            Text("Track product")
                        }.disabled(!viewModel.isAProduct).foregroundColor(viewModel.isAProduct ? Color("AmazonText") : Color("AmazonText").opacity(0.5))
                    } else {
                        Button{
                            viewModel.addProduct()
                        } label: {
                            Text("Add product")
                        }.disabled(!viewModel.isAProduct).foregroundColor(viewModel.isAProduct ? Color("AmazonText") : Color("AmazonText").opacity(0.5))
                    }
                    Spacer()
                    Button{
                        viewModel.shouldGoForward.toggle()
                    } label: {
                        Image(systemName: "chevron.right")
                    }.disabled(!viewModel.canGoForward)
                        .foregroundColor(viewModel.canGoForward ? Color("AmazonText") : Color("AmazonText").opacity(0.5))
                }.padding(.horizontal)
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    
            }
            if(viewModel.showLoader){
                ZStack{
                    Color("LabelColor").opacity(0.4)
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("BackgroundColor"))).scaleEffect(x: 2, y: 2, anchor: .center)
                }.ignoresSafeArea()
            }
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(isShown: .constant(true))
    }
}
