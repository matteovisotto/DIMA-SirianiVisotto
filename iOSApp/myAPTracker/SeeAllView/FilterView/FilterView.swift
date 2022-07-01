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
                        self.viewModel.save()
                        self.viewModel.isPresented.wrappedValue.toggle()
                    } label: {
                        Text("Done")
                    }.accessibilityIdentifier("FilterViewCloseCategories")
                }
                Text("Select one or more categories to visualize").font(.callout).padding(.top)
                    .foregroundColor(Color("PrimaryLabel")).accessibilityIdentifier("FilterViewSelectMoreCategories")
                List{
                    Section{
                        ForEach(self.viewModel.categories, id: \.self) { category in
                            FilterCellView(title: category.capitalizingFirstLetter(), isSelected: self.viewModel.selected.contains(category)) {
                                if self.viewModel.selected.contains(category) {
                                    self.viewModel.selected.removeAll(where: {$0 == category})
                                } else {
                                    self.viewModel.selected.append(category)
                                }
                            }
                        }
                    }
                    Section{
                        Button{
                            self.viewModel.selected = []
                        } label: {
                            Text("Clear filters")
                        }.foregroundColor(Color.red)
                    }
                }
                
            }.padding()
        }
    }
}

