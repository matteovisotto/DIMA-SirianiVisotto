//
//  IconSecureTextField.swift
//  APTracker
//
//  Created by Matteo Visotto on 05/04/22.
//

import SwiftUI

struct IconSecureTextField: View {
    @State private var isValid: Bool = false
    var titleKey: LocalizedStringKey
    var text: Binding<String>
    var icon: Image? = nil
    var foregroundColor: Color = Color(UIColor.label)
    var body: some View {
        VStack (spacing: 0){
             HStack(spacing: 0){
                 icon.padding(8).font(.caption).foregroundColor(foregroundColor)
                 SecureField(titleKey, text: text).frame(height: 35).textFieldStyle(DefaultTextFieldStyle()).textContentType(.password)
                 Image(systemName: "checkmark.seal").foregroundColor(foregroundColor).opacity(isValid ? 1 : 0)
             }
            Rectangle().frame(height: 1)
            .foregroundColor(foregroundColor)
            .padding(.leading, 10)
        }
    }
}

struct IconSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        
        IconTextField(titleKey: "Prova", text: .constant(""), icon: Image(systemName: "person.fill")).padding()
        
        
    }
}
