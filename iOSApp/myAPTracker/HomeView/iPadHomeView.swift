//
//  HomeView.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import Foundation
import SwiftUI
import SwiftfulLoadingIndicators

struct iPadHomeView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var mainModel: MainViewModel
    @ObservedObject var viewModel: iPadHomeViewModel
   
    @State var trackedDisplayIndex: Int = 0

    init(mainViewModel: MainViewModel) {
        self.mainModel = mainViewModel
        self.viewModel = iPadHomeViewModel()
    }
    

    var body: some View {
        ZStack{
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 10){
                            if(AppState.shared.isUserLoggedIn && viewModel.trackingLoading){
                                Text("Your last added products").font(.system(size: 20).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel")).frame(maxWidth: .infinity, alignment: .leading).padding(.leading).padding(.bottom, 5).accessibilityIdentifier("HomeViewLastProductText")
                                    LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                                
                            }
                            if(AppState.shared.isUserLoggedIn && viewModel.trackingObjects.count > 0){
                                Text("Your last added products").font(.system(size: 20).bold()).multilineTextAlignment(.leading).foregroundColor(Color("PrimaryLabel")).frame(maxWidth: .infinity, alignment: .leading).padding(.leading).padding(.bottom, 5).accessibilityIdentifier("HomeViewLastProductText")
                                DoublePagingView(index: $trackedDisplayIndex.animation(), maxIndex: (viewModel.trackingObjects.count - 1)/2) {
                                    ForEach((0..<viewModel.trackingObjects.count).reversed(), id: \.self){ index in
                                        NavigationLink {
                                                iPadProductView(product: Product.fromTracked(viewModel.trackingObjects[index]))
                                            } label: {
                                                TrackedProductView(viewModel.trackingObjects[index]).padding(.horizontal, 10)
                                                
                                            }.highPriorityGesture(DragGesture())
                                            .accessibilityIdentifier("HomeViewLastTrackedButton\(index)")
                                    }
                                }.frame(width: geometry.size.width, height: 150).accessibilityIdentifier("HomeViewPagingView")
                                Divider()
                            }
                            HStack{
                                Text("Categories").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("HomeViewCategoriesText")
                                Spacer()
                            }.padding(.horizontal)
                            ZStack{
                            VStack(spacing: 10) {
                                HGrid(numberOfRows: 2, numberOfItems: viewModel.categories.count, elemPerRow: 3) { contentIndex in
                                    NavigationLink{
                                        iPadSeeAllView(apiUrl: AppConstant.getAllPaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Filtered", comment: "Filtered"), appliedFilter: [viewModel.categories[contentIndex]])
                                    } label: {
                                            ZStack{
                                                Color("CategoryColor")
                                                Text(viewModel.categories[contentIndex].capitalizingFirstLetter()).foregroundColor(Color("BackgroundColor")).font(.title3.bold())
                                            }.cornerRadius(10)
                                    
                                    }.highPriorityGesture(DragGesture())
                                        .accessibilityIdentifier("HomeViewCategoryButton\(contentIndex)")
                                }.frame(width: geometry.size.width, height: 190)
                            }
                                if(viewModel.categoryLoading){
                                    LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                                }
                            }
                            HStack{
                                Text("Most tracked").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("HomeViewMostTrackedText")
                                Spacer()
                                NavigationLink {
                                    iPadSeeAllView(apiUrl: AppConstant.getMostTrackedPaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Most tracked", comment: "Most tracked"))
                                } label: {
                                    Text("See All")
                                }.accessibilityIdentifier("HomeViewSeeAllButton")
                            }.padding(.horizontal)
                            ZStack{
                            VStack(spacing: 10) {
                                HGrid(numberOfRows: 3, numberOfItems: viewModel.mostTracked.count, elemPerRow: 2) { contentIndex in
                                    NavigationLink{
                                        iPadProductView(product: viewModel.mostTracked[contentIndex])
                                    } label: {
                                        VStack{
                                            SingleProductView(viewModel.mostTracked[contentIndex]).foregroundColor(Color("PrimaryLabel"))
                                            Divider()
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




