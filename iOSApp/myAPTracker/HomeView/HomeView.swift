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
                            if(appState.isUserLoggedIn && viewModel.trackingLoading){
                                Text("Your last added products").font(.system(size: 20).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel")).frame(maxWidth: .infinity, alignment: .leading).padding(.leading).padding(.bottom, 5).accessibilityIdentifier("HomeViewLastProductText")
                                    LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                                
                            }
                            if(appState.isUserLoggedIn && viewModel.trackingObjects.count > 0){
                                Text("Your last added products").font(.system(size: 20).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel")).frame(maxWidth: .infinity, alignment: .leading).padding(.leading).padding(.bottom, 5).accessibilityIdentifier("HomeViewLastProductText")
                               
                                PagingView(index: $trackedDisplayIndex.animation(), maxIndex: viewModel.trackingObjects.count - 1) {
                                    ForEach((0..<viewModel.trackingObjects.count).reversed(), id: \.self){ index in
                                        NavigationLink {
                                                ProductView(product: Product.fromTracked(viewModel.trackingObjects[index]))
                                            } label: {
                                                TrackedProductView(viewModel.trackingObjects[index]).padding(.horizontal, 10)
                                                
                                            }.highPriorityGesture(DragGesture())
                                    }
                                }.frame(width: geometry.size.width, height: 150).accessibilityIdentifier("HomeViewPagingView")
                                Divider()
                            }
                            HStack{
                                Text("Most tracked").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("HomeViewMostTrackedText")
                                Spacer()
                                NavigationLink {
                                    SeeAllView(apiUrl: AppConstant.getMostTrackedPaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Most tracked", comment: "Most tracked"))
                                } label: {
                                    Text("See All")
                                }.accessibilityIdentifier("HomeViewSeeAllButton")
                            }.padding(.horizontal)
                            ZStack{
                            VStack(spacing: 10) {
                                HGrid(numberOfRows: 3, numberOfItems: viewModel.mostTracked.count, elemPerRow: 1) { contentIndex in
                                    NavigationLink{
                                        ProductView(product: viewModel.mostTracked[contentIndex])
                                    } label: {
                                        VStack{
                                            SingleProductView(viewModel.mostTracked[contentIndex]).foregroundColor(Color("PrimaryLabel"))
                                            Divider().padding(.leading, 10)
                                        }
                                    }.highPriorityGesture(DragGesture())
                                        .accessibilityIdentifier("HomeViewMostrTrackedButton\(contentIndex)")
                                    
                                }.frame(width: geometry.size.width, height: 330)
                            }
                                if(viewModel.isLoading){
                                    LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                                }
                            }
                        }
                        
                    }.onAppear(perform: viewModel.loadData)
            }
            
        }
    
}
   
}



