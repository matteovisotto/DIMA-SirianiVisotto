//
//  ProductView.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//


import SwiftUI
import LineChartView

struct ProductView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: ProductViewModel
    
    init(product: Product){
        viewModel = ProductViewModel(product: product)
    }
    
    var body: some View{
        ZStack{
            Color("BackgroundColor").ignoresSafeArea(.all)
            GeometryReader{ geometry in
                VStack(alignment: .leading){
                    HStack{
                        Button{
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left").font(.title3.bold())
                        }.foregroundColor(Color("PrimaryLabel"))
                        Spacer()
                    }.padding(.bottom,3)
                    Text(viewModel.product.name).lineLimit(2).font(.title2.bold()).foregroundColor(Color("PrimaryLabel"))
                    MenuBar(selection: $viewModel.selectedTab, items: viewModel.menuItems, background: Color("Primary"), foreground: Color("PrimaryLabel")).frame(height: 40)
                    
                        if(viewModel.selectedTab=="price"){
                            PriceView(viewModel: viewModel)
                        } else if(viewModel.selectedTab == "comment"){
                            CommentView(viewModel: viewModel)
                        } else if(viewModel.selectedTab == "detail"){
                            DetailView(viewModel: viewModel)
                        }
                    
                    Spacer()
                    HStack{
                        Text("\(viewModel.product.price!, specifier: "%.2f") €").padding(.leading).font(.title3.bold()).foregroundColor(Color("PrimaryLabel"))
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
            if(appState.isUserLoggedIn){
                VStack{
                    HStack{
                        Spacer()
                        Button{
                           
                        } label: {
                            Image(systemName: "doc.badge.gearshape").font(.title3.bold())
                        }.foregroundColor(Color("PrimaryLabel"))
                    }.padding(.bottom,3)
                    Spacer()
                }.padding(.horizontal, 15)
                    .padding(.vertical, 10)
            }
            
            
        }.navigationBarHidden(true)
    }
}

