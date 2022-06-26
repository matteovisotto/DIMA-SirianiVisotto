//
//  SeeAllView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 19/05/22.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct SeeAllView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
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
                        HStack(alignment: .center){
                            Button{
                                mode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrow.left").font(.title3.bold())
                            }.foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                            Button{
                                viewModel.showFilterView.toggle()
                            }  label: {
                                Image(systemName: "line.3.horizontal.decrease")
                            }.frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color("PrimaryLabel"))
                                .background(Color("PrimaryLabel").opacity(0.15))
                                .clipShape(Circle())
                                .accessibilityIdentifier("SeeAllViewCategoriesButton")
                        }
                        Spacer().frame(height: 8)
                        HStack{
                            Text(viewModel.viewTitle).font(.largeTitle.bold()).foregroundColor(Color("PrimaryLabel"))
                                .accessibilityIdentifier("SeeAllViewTitle")
                            Spacer()
                            
                        }
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
        }.navigationBarHidden(true)
            .sheet(isPresented: $viewModel.showFilterView) {
                FilterView(isPresented: $viewModel.showFilterView, selectedCategories: $viewModel.categoryFilters)
            }
    }
}

