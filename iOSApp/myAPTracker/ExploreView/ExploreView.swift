//
//  ExploreView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct ExploreView: View {
    @ObservedObject var viewModel: ExploreViewModel = ExploreViewModel()
    
    var body: some View {
        ZStack{
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        HStack{
                            Text("Most tracked").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                            NavigationLink {
                                SeeAllView(apiUrl: AppConstant.getMostTrackedPaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Most Tracked", comment: "Most Tracked"))
                            } label: {
                                Text("See All")
                            }

                        }.padding(.horizontal)
                        VStack(spacing: 10) {
                            HGrid(numberOfRows: 2, numberOfItems: viewModel.mostTracked.count) { contentIndex in
                                NavigationLink{
                                    ProductView(product: viewModel.mostTracked[contentIndex])
                                } label: {
                                    VStack{
                                        SingleProductView(viewModel.mostTracked[contentIndex]).frame(width: ((geometry.size.width)-40), height: 100).padding(.leading, 10).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                        //Divider().padding(.leading, 10)
                                    }
                                }
                            }
                            /*ForEach(0 ..< viewModel.mostTracked.count, id: \.self){ contentIndex in
                                NavigationLink{
                                    ProductView(product: viewModel.mostTracked[contentIndex])
                                } label: {
                                    VStack{
                                        SingleProductView(viewModel.mostTracked[contentIndex]).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                        Divider().padding(.leading, 10)
                                    }
                                }
                                
                            }*/
                        }.padding(.horizontal, 10)
                        Divider().padding(.leading, 10)
                        HStack{
                            Text("Biggest percentual drop").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                            NavigationLink {
                                SeeAllView(apiUrl: AppConstant.getLastPriceDropPercentagePaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Biggest percentual drop", comment: "Biggest percentual drop"))
                            } label: {
                                Text("See All")
                            }
                        }.padding(.horizontal)
                        VStack(spacing: 10) {
                            HGrid(numberOfRows: 2, numberOfItems: viewModel.biggestPercentageDrop.count) { contentIndex in
                                NavigationLink{
                                    ProductView(product: Product.fromPriceDrop(viewModel.biggestPercentageDrop[contentIndex]))
                                } label: {
                                    VStack{
                                        SingleProductView(Product.fromPriceDrop(viewModel.biggestPercentageDrop[contentIndex])).frame(width: ((geometry.size.width)-40), height: 100).padding(.leading, 10).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                    }
                                }
                            }
                        }.padding(.horizontal, 10)
                        Divider().padding(.leading, 10)
                        HStack{
                            Text("Biggest range drop").font(Font.system(size: 20).bold()).foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                            NavigationLink {
                                SeeAllView(apiUrl: AppConstant.getPriceDropPaging + "?limit=20&page=0", viewTitle: NSLocalizedString("Biggest range drop", comment: "Biggest range drop"))
                            } label: {
                                Text("See All")
                            }
                        }.padding(.horizontal)
                        VStack(spacing: 10) {
                            HGrid(numberOfRows: 2, numberOfItems: viewModel.biggestRangeDrop.count) { contentIndex in
                                NavigationLink{
                                    ProductView(product: Product.fromPriceDrop(viewModel.biggestRangeDrop[contentIndex]))
                                } label: {
                                    VStack{
                                        SingleProductView(Product.fromPriceDrop(viewModel.biggestRangeDrop[contentIndex])).frame(width: ((geometry.size.width)-40), height: 100).padding(.leading, 10).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                    }
                                }
                            }
                        }.padding(.horizontal, 10)
                    }.onAppear(perform: viewModel.loadData)
            }
            if(viewModel.isLoading){
                LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
