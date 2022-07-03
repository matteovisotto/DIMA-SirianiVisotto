//
//  ProductView.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//


import SwiftUI

struct iPadProductView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: ProductViewModel
    
    init(product: Product){
        viewModel = iPadProductViewModel(product: product)
    }
    
    var body: some View{
        ZStack{
            Color("BackgroundColor").ignoresSafeArea(.all)
            GeometryReader{ geometry in
                VStack(alignment: .leading){
                    HStack(spacing:0 ){
                        VStack{
                            PriceView(viewModel: viewModel)
                        }.frame(maxWidth: geometry.size.width > geometry.size.height ? (geometry.size.width*2/3)-10 : (geometry.size.width/2)-10)
                        VStack{
                            MenuBar(selection: $viewModel.selectedTab, items: viewModel.menuItems, background: Color("Primary"), foreground: Color("PrimaryLabel")).frame(height: 40)
                            if(viewModel.selectedTab == "comment"){
                                CommentView(viewModel: viewModel)
                            } else if(viewModel.selectedTab == "detail"){
                                DetailView(viewModel: viewModel)
                            }
                        }.frame(maxWidth: geometry.size.width > geometry.size.height ? (geometry.size.width/3)-10 : (geometry.size.width/2)-10).padding(.horizontal)
                    }
                        
                    
                    Spacer()
                    HStack{
                        Text("\(viewModel.product.price!, specifier: "%.2f") €").padding(.leading).font(.title3.bold()).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("ProductViewiPadProductPrice")
                        Spacer()
                        Button{
                            if let url = URL(string: viewModel.product.link) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Text("Open in Amazon")
                        }.padding(.horizontal)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                            .background(Color("Primary"))
                            .cornerRadius(10)
                    }
                    .frame(width: geometry.size.width-30, height: 50)
                    .padding(.horizontal, 0)
                    
                }.padding(.horizontal,15)
                    .padding(.vertical, 10)
            }.onAppear {
                viewModel.loadData()
            }
            
        }.navigationTitle(viewModel.product.shortName)
            .toolbar(content: {
                if(appState.isUserLoggedIn){
        
                            Menu {
                                if(viewModel.trackedStatus?.tracked ?? false){
                                    Button {
                                        viewModel.openSetting = true
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }.accessibilityIdentifier("ProductViewSettingsButton")
                                    Button {
                                        viewModel.stopTracking()
                                        viewModel.trackedStatus?.tracked = false;
                                    } label: {
                                        Label("Stop tracking", systemImage: "minus")
                                    }.accessibilityIdentifier("ProductViewStopTrackProduct")
                                } else {
                                    Button {
                                        viewModel.startTracking()
                                        viewModel.trackedStatus?.tracked = true;
                                    } label: {
                                        Label("Start tracking", systemImage: "plus")
                                    }.accessibilityIdentifier("ProductViewStartTrackProduct")
                                }
                            } label: {
                                Image(systemName: "doc.badge.gearshape")//.font(.title3.bold())
                            }.foregroundColor(Color("PrimaryLabel"))
                                .accessibilityIdentifier("ProductViewSettingsTrackingButton")
                }
            }).sheet(isPresented: $viewModel.openSetting) {
                //if let binding = Binding<TrackingStatus>($viewModel.trackedStatus){
                UpdateTrackingView(isOpen: $viewModel.openSetting, price: viewModel.product.price!, status: Binding($viewModel.trackedStatus)!) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.viewModel.updateTracking()
                        }
                        
                    }
                //}
            }
    }
}


