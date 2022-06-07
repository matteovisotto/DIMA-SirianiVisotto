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
                        HStack{
                            Button{
                                mode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrow.left").font(.title3.bold())
                            }.foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                        }
                        Spacer().frame(height: 8)
                        HStack{
                            Text(viewModel.viewTitle).font(.largeTitle.bold()).foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                            Button{
                                viewModel.showFilterView.toggle()
                            }  label: {
                                Image(systemName: "line.3.horizontal.decrease")
                            }.frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color("PrimaryLabel"))
                                .background(Color("PrimaryLabel").opacity(0.15))
                                .clipShape(Circle())
                        }
                        Text(viewModel.categoryFilters.joined(separator: ",")).font(.caption).foregroundColor(Color("PrimaryLabel"))
                        InfiniteList(data: viewModel.categoryFilters.count > 0 ? $viewModel.filteredProducts : $viewModel.products, isLoading: $viewModel.isLoading, loadMore: viewModel.loadMore ){contentIndex in
                            NavigationLink{
                                ProductView(product: viewModel.categoryFilters.count > 0 ? viewModel.filteredProducts[contentIndex] : viewModel.products[contentIndex])
                            } label: {
                                VStack{
                                    SingleProductView(viewModel.categoryFilters.count > 0 ? viewModel.filteredProducts[contentIndex] : viewModel.products[contentIndex]).frame(width: ((geometry.size.width)-40), height: 100).padding(.bottom, 10).foregroundColor(Color("PrimaryLabel"))
                                    Divider().padding(.leading, 10)
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

