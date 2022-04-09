//
//  IconTextField.swift
//  APTracker
//
//  Created by Matteo Visotto on 05/04/22.
//

import SwiftUI

struct IconTextField: View {
    @State private var isValid: Bool = false
    @State private var hasInput: Bool = false
    var titleKey: LocalizedStringKey
    var text: Binding<String>
    var icon: Image? = nil
    var foregroundColor: Color = Color(UIColor.label)
    var showValidator: Bool = true
    var validator: (_ text: String) -> Bool = {text in return false}
    var body: some View {
        VStack (spacing: 0){
             HStack(spacing: 0){
                 icon.padding(8).font(.caption).foregroundColor(foregroundColor)
                 TextField(titleKey, text: text, onEditingChanged: { isChanged in
                     if !(text.wrappedValue.count == 0) {
                         hasInput = true
                         self.isValid = validator(text.wrappedValue)
                     } else {
                         hasInput = false
                     }
                 }).frame(height: 35).textFieldStyle(DefaultTextFieldStyle())
                     .foregroundColor(foregroundColor)
                 if(showValidator){
                 Image(systemName: isValid ? "checkmark.seal" : "xmark.seal").foregroundColor(isValid ? .green : .red).opacity(hasInput ? 1 : 0)
                 }
             }
            Rectangle().frame(height: 1)
            .foregroundColor(foregroundColor)
            .padding(.leading, 10)
        }
    }
}

struct IconTextField_Previews: PreviewProvider {
    static var previews: some View {
        
        IconTextField(titleKey: "Prova", text: .constant(""), icon: Image(systemName: "person.fill")).padding()
        
        
    }
}
