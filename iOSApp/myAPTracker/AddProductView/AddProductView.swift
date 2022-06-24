//
//  AddProductView.swift
//  APTracker
//
//  Created by Matteo Visotto on 09/04/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

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
                    IconTextField(titleKey: "", text: $viewModel.currentUrl, icon: Image(systemName: "link"), foregroundColor: Color("AmazonText"), showValidator: false).accessibilityIdentifier("AddProductViewAmazonTextField")
                    Button{
                        viewModel.shouldReloadWithGivenUrl.toggle()
                    } label: {
                        Image(systemName: "arrowtriangle.right")
                    }.disabled(viewModel.isWebViewLoading)
                        .foregroundColor(viewModel.isWebViewLoading ? Color("AmazonText").opacity(0.5) : Color("AmazonText"))
                        .accessibilityIdentifier("AddProductViewAmazonSearch")
                }.padding()
                WebView(viewModel, stringUrl: "https://amazon.it").textFieldStyle(.roundedBorder)
                HStack{
                    Button{
                        viewModel.shouldGoBack.toggle()
                    } label: {
                        Image(systemName: "chevron.left")
                    }.disabled(!viewModel.canGoBack)
                        .foregroundColor(viewModel.canGoBack ? Color("AmazonText") : Color("AmazonText").opacity(0.5))
                        .accessibilityIdentifier("AddProductViewGoBackButton")
                    Spacer()
                    if(appState.isUserLoggedIn){
                        Button{
                            viewModel.addTracking()
                        } label: {
                            Text("Track product")
                        }.disabled(!viewModel.isAProduct).foregroundColor(viewModel.isAProduct ? Color("AmazonText") : Color("AmazonText").opacity(0.5)).accessibilityIdentifier("AddProductViewTrackButton")
                    } else {
                        Button{
                            viewModel.addProduct()
                        } label: {
                            Text("Add product")
                        }.disabled(!viewModel.isAProduct).foregroundColor(viewModel.isAProduct ? Color("AmazonText") : Color("AmazonText").opacity(0.5)).accessibilityIdentifier("AddProductViewAddButton")
                    }
                    Spacer()
                    Button{
                        viewModel.shouldGoForward.toggle()
                    } label: {
                        Image(systemName: "chevron.right")
                    }.disabled(!viewModel.canGoForward)
                        .foregroundColor(viewModel.canGoForward ? Color("AmazonText") : Color("AmazonText").opacity(0.5))
                        .accessibilityIdentifier("AddProductViewGoForwardButton")
                }.padding(.horizontal)
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    
            }
            if(viewModel.showLoader){
                ZStack{
                    Color("LabelColor").opacity(0.4)
                    LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
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
