//
//  SocialButton.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

struct SocialSmallButton: View {
    
    var icon: Image
    var borderColor: Color = Color(UIColor.label)
    var action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            icon
                .resizable()
                .frame(width: 35, height: 35)
        }.padding(10)
            .background(Color.clear)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 1))
            
    }
    
}

struct SocialSmallButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialSmallButton(icon: Image("google-logo")){
            
        }
    }
}

