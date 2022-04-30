//
//  MenuButton.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import SwiftUI

struct MenuButton: View {
    
    var icon: Image
    var name: LocalizedStringKey
    var background: Color
    var foreground: Color
    var tag: String
    var selection: Binding<String>
    var action: () -> Void
   
    
    var body: some View {
        GeometryReader{ geom in
            Button{
                action()
            } label: {
                HStack(spacing: 0){
                    icon.font(.footnote)
                    Text(name).font(.footnote).frame(maxWidth: .infinity)
                }
            }
            .foregroundColor(selection.wrappedValue == tag ? .white : background)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(selection.wrappedValue == tag ? background : Color.clear)
            .cornerRadius(geom.size.height/2)
        }
        
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(icon: Image(systemName: "person.fill"), name: "Comments", background: Color("Primary"), foreground: .white, tag: "prova", selection: .constant("prova")){
            
        }
    }
}
