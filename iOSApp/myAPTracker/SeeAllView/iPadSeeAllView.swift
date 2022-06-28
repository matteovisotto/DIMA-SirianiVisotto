//
//  SeeAllView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 19/05/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct iPadSeeAllView: View {
    @ObservedObject var viewModel: SeeAllViewModel
    
    init(apiUrl: String, viewTitle: String){
        UITableView.appearance().backgroundColor = .clear
        viewModel = SeeAllViewModel(apiUrl: apiUrl, viewTitle: viewTitle)
    }
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea(.all)
                GeometryReader{ geometry in
                    VStack{
                        Text(viewModel.categoryFilters.joined(separator: ", ")).font(.caption).foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("SeeAllViewCategoryFilterText")
                        
                        if(viewModel.categoryFilters.count > 0){
                            InfiniteList(data: $viewModel.filteredProducts, isLoading: $viewModel.isLoading, loadMore: viewModel.loadMore ){contentIndex in
                                NavigationLink{
                                    ProductView(product: viewModel.filteredProducts[contentIndex])
                                } label: {
                                    VStack{
                                        SingleProductView(viewModel.filteredProducts[contentIndex]).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                        Divider().padding(.leading, 10)
                                    }
                                }
                            }
                        } else {
                           
                            InfiniteList(data: $viewModel.products, isLoading: $viewModel.isLoading, loadMore: viewModel.loadMore ){contentIndex in
                                NavigationLink{
                                    ProductView(product: viewModel.products[contentIndex])
                                } label: {
                                    VStack{
                                        SingleProductView(viewModel.products[contentIndex]).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                        Divider().padding(.leading, 10)
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal,15)
                        .padding(.vertical, 10)
                    
            }
            if(viewModel.isLoading){
                LoadingIndicator(animation: .threeBallsBouncing, color: Color("Primary"), size: .medium, speed: .normal)
            }
        }.navigationTitle(viewModel.viewTitle)
            .toolbar(content: {
                Button{
                    viewModel.showFilterView.toggle()
                }  label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }.foregroundColor(Color("PrimaryLabel"))
            })
            .sheet(isPresented: $viewModel.showFilterView) {
                FilterView(isPresented: $viewModel.showFilterView, selectedCategories: $viewModel.categoryFilters)
            }
    }
}



