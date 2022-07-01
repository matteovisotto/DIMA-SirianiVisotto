//
//  InfiniteList.swift
//  myAPTracker
//
//  Created by Tia on 22/05/22.
//

import SwiftUI
import Combine

struct InfiniteList<Content>: View where Content: View {
    @Binding var data: [Product]
    @Binding var isLoading: Bool
    let loadMore: () -> Void
    let content: (Int) -> Content

  init(data: Binding<Array<Product>>, isLoading: Binding<Bool>, loadMore: @escaping () -> Void, @ViewBuilder content: @escaping (Int) -> Content) {
      UITableView.appearance().showsVerticalScrollIndicator = false
      UITableView.appearance().separatorColor = .clear
      _data = data
      _isLoading = isLoading
      self.loadMore = loadMore
      self.content = content
  }

  var body: some View {
    List {
        Section{
            ForEach(0..<data.count, id: \.self) { index in
                content(index)
                    .onAppear {
                        if index == data.count-1 {
                            loadMore()
                        }
                    }
            }
            /*if isLoading {
                ProgressView()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            }*/
            
        }.listRowBackground(Color.clear)
    }.listStyle(.plain).onAppear(perform: loadMore)
  }
}

struct DoubleInfiniteList<Content>: View where Content: View {
    @Binding var data: [Product]
    @Binding var isLoading: Bool
    let loadMore: () -> Void
    let content: (Int) -> Content
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

  init(data: Binding<Array<Product>>, isLoading: Binding<Bool>, loadMore: @escaping () -> Void, @ViewBuilder content: @escaping (Int) -> Content) {
      UITableView.appearance().showsVerticalScrollIndicator = false
      UITableView.appearance().separatorColor = .clear
      _data = data
      _isLoading = isLoading
      self.loadMore = loadMore
      self.content = content
  }

  var body: some View {
      ScrollView{
          LazyVGrid(columns: columns, spacing: 20) {
       
            ForEach(0..<data.count, id: \.self) { index in
                content(index)
                    .onAppear {
                        if index == data.count-2 {
                            loadMore()
                        }
                    }
            }
            /*if isLoading {
                ProgressView()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            }*/
            
          }
    }.onAppear(perform: loadMore)
  }
}
