//
//  FullScreenDismissableContainerView.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 29/06/22.
//

import SwiftUI

struct FullScreenDismissableContainerView<Content: View>: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var content: () -> Content
    var title: String
    var body: some View {
        
            NavigationView{
                ZStack{
                    Color("BackgroundColor").ignoresSafeArea(.all)
    
                    content().frame(maxWidth: .infinity, maxHeight: .infinity)
                            .navigationTitle(title).toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button{
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "multiply")
                        }.foregroundColor(Color("PrimaryLabel"))
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}
