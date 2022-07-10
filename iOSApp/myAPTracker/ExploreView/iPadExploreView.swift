//
//  ExploreView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct iPadExploreView: View {
    @ObservedObject var viewModel: ExploreViewModel = ExploreViewModel()
    
    var body: some View {
        ZStack{
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        HStack{
                            Text("Most tracked").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("ExploreViewFirstTitle")
                            Spacer()
                            NavigationLink {
                                iPadSeeAllView(apiUrl: AppConstant.getMostTrackedPaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Most Tracked", comment: "Most Tracked"))
                            } label: {
                                Text("See All")
                            }.accessibilityIdentifier("ExploreViewFirstSeeAll")

                        }.padding(.horizontal)
                        ZStack{
                        VStack(spacing: 10) {
                            HGrid(numberOfRows: 3, numberOfItems: viewModel.mostTracked.count, elemPerRow: 2) { contentIndex in
                                NavigationLink{
                                    iPadProductView(product: viewModel.mostTracked[contentIndex])
                                } label: {
                                    VStack{
                                        SingleProductView(viewModel.mostTracked[contentIndex]).foregroundColor(Color("PrimaryLabel"))
                                        //Divider().padding(.leading, 10)
                                    }
                                }.highPriorityGesture(DragGesture())
                                    .accessibilityIdentifier("ExploreViewFirstProduct\(contentIndex)")
                            }.frame(width: geometry.size.width-20, height: 330)
                            
                        }.padding(.horizontal, 10)
                            if(viewModel.loading1){
                                LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                            }
                        }
                        Divider().padding(.leading, 10)
                        HStack{
                            Text("Biggest percentual drop").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("ExploreViewSecondTitle")
                            Spacer()
                            NavigationLink {
                                iPadSeeAllView(apiUrl: AppConstant.getLastPriceDropPercentagePaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Biggest percentual drop", comment: "Biggest percentual drop"))
                            } label: {
                                Text("See All")
                            }.accessibilityIdentifier("ExploreViewSecondSeeAll")
                        }.padding(.horizontal)
                        ZStack{
                        VStack(spacing: 10) {
                            HGrid(numberOfRows: 3, numberOfItems: viewModel.biggestPercentageDrop.count, elemPerRow: 2) { contentIndex in
                                NavigationLink{
                                    iPadProductView(product: Product.fromPriceDrop(viewModel.biggestPercentageDrop[contentIndex]))
                                } label: {
                                    VStack{
                                        SingleProductView(Product.fromPriceDrop(viewModel.biggestPercentageDrop[contentIndex])).foregroundColor(Color("PrimaryLabel"))
                                    }
                                }.highPriorityGesture(DragGesture())
                                    .accessibilityIdentifier("ExploreViewSecondProduct\(contentIndex)")
                            }.frame(width: geometry.size.width-20, height: 330)
                        }.padding(.horizontal, 10)
                            if(viewModel.loading2){
                                LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                            }
                        }
                        Divider().padding(.leading, 10)
                        HStack{
                            Text("Biggest range drop").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("ExploreViewThirdTitle")
                            Spacer()
                            NavigationLink {
                                iPadSeeAllView(apiUrl: AppConstant.getPriceDropPaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Biggest range drop", comment: "Biggest range drop"))
                            } label: {
                                Text("See All")
                            }.accessibilityIdentifier("ExploreViewThirdSeeAll")
                        }.padding(.horizontal)
                        ZStack{
                        VStack(spacing: 10) {
                            HGrid(numberOfRows: 3, numberOfItems: viewModel.biggestRangeDrop.count, elemPerRow: 2) { contentIndex in
                                NavigationLink{
                                    iPadProductView(product: Product.fromPriceDrop(viewModel.biggestRangeDrop[contentIndex]))
                                } label: {
                                    VStack{
                                        SingleProductView(Product.fromPriceDrop(viewModel.biggestRangeDrop[contentIndex])).foregroundColor(Color("PrimaryLabel"))
                                    }
                                }.highPriorityGesture(DragGesture())
                                    .accessibilityIdentifier("ExploreViewThirdProduct\(contentIndex)")
                            }.frame(width: geometry.size.width-20, height: 330)
                        }.padding(.horizontal, 10)
                            if(viewModel.loading3){
                                LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
                            }
                        }
                    }.onAppear(perform: viewModel.loadData)
            }
            
        }
    }
}

