//
//  HomeView.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import Foundation
import SwiftUI
import SwiftfulLoadingIndicators

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var mainModel: MainViewModel
    @ObservedObject var viewModel: HomeViewModel
   
    @State var trackedDisplayIndex: Int = 0

    init(mainViewModel: MainViewModel) {
        self.mainModel = mainViewModel
        self.viewModel = HomeViewModel()
    }
    

    var body: some View {
        ZStack{
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 10){
                            if(appState.isUserLoggedIn && viewModel.trackingObjects.count > 0){
                                
                                PagingView(index: $trackedDisplayIndex.animation(), maxIndex: viewModel.trackingObjects.count - 1) {
                                    ForEach(0..<viewModel.trackingObjects.count, id: \.self){ index in
                                        NavigationLink {
                                                ProductView(product: Product.fromTracked(viewModel.trackingObjects[index]))
                                            } label: {
                                                TrackedProductView(viewModel.trackingObjects[index]).padding(.horizontal, 10)
                                                
                                            }.highPriorityGesture(DragGesture())
                                    }
                                }.frame(width: geometry.size.width, height: 200)
                                
                                Divider()
                            }
                            HStack{
                                Text("Most tracked").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel"))
                                Spacer()
                                Button{
                                    mainModel.selectedTab = 2
                                } label: {
                                    Text("See all")
                                }
                            }.padding(.horizontal)
                            VStack(spacing: 10) {
                                HGrid(numberOfRows: 3, numberOfItems: viewModel.mostTracked.count) { contentIndex in
                                    NavigationLink{
                                        ProductView(product: viewModel.mostTracked[contentIndex])
                                    } label: {
                                        VStack{
                                            SingleProductView(viewModel.mostTracked[contentIndex]).frame(width: ((geometry.size.width)-40), height: 100).padding(.leading, 10).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                            Divider().padding(.leading, 10)
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                    }.onAppear(perform: viewModel.loadData)
            }
            if(viewModel.isLoading){
                LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
            }
        }
    
}
   
}



