//
//  MenuBar.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import SwiftUI

struct MenuBarItem: Identifiable {
    var id = UUID().uuidString
    var tag: String
    var title: LocalizedStringKey
    var icon: Image
}

struct MenuBar: View {
    
    var selection: Binding<String>
    var items: [MenuBarItem]
    var background: Color = Color.black
    var foreground: Color = Color.white
    
    var body: some View {
        GeometryReader{ g in
            HStack(alignment: .center, spacing: 0){
                    ForEach(items) { item in
                        MenuButton(icon: item.icon, name: item.title, background: background, foreground: foreground, tag: item.tag, selection: selection){
                                selection.wrappedValue = item.tag
                        }.frame(maxWidth: .infinity)
                }
            }
        }
        
        
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar(selection: .constant("prova0"), items: [MenuBarItem(tag: "prova0", title: "Prices", icon: Image(systemName: "creditcard.fill")), MenuBarItem(tag: "prova1", title: "Details", icon: Image(systemName: "text.justify")),MenuBarItem(tag: "prova2", title: "Comments", icon: Image(systemName: "message.fill"))]).frame(height: 44).padding()
    }
}
