//
//  FilterView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 07/06/22.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: FilterViewModel
    
    init(isPresented: Binding<Bool>, selectedCategories: Binding<Array<String>>){
        UITableView.appearance().backgroundColor = .clear
        self.viewModel = FilterViewModel(isPresented: isPresented, selectedCategories: selectedCategories)
    }
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Button{
                        self.viewModel.isPresented.wrappedValue.toggle()
                    } label: {
                        Text("Done")
                    }
                }
                Text("Select one or more categories to visualize").font(.callout).padding(.top)
                    .foregroundColor(Color("PrimaryLabel"))
                List{
                    Section{
                        ForEach(self.viewModel.categories, id: \.self) { category in
                            FilterCellView(title: category, isSelected: self.viewModel.selected.wrappedValue.contains(category)) {
                                if self.viewModel.selected.wrappedValue.contains(category) {
                                    self.viewModel.selected.wrappedValue.removeAll(where: {$0 == category})
                                } else {
                                    self.viewModel.selected.wrappedValue.append(category)
                                }
                            }
                        }
                    }
                    Section{
                        Button{
                            self.viewModel.selected.wrappedValue = []
                            //self.viewModel.isPresented.wrappedValue.toggle()
                        } label: {
                            Text("Clear filters")
                        }.foregroundColor(Color.red)
                    }
                }
                
            }.padding()
            
        }
    }
}

