//
//  SocialButton.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

struct SocialButton: View {
    
    var icon: Image
    var name: LocalizedStringKey
    var background: Color
    var foreground: Color
    var action: () -> Void
    
    var body: some View {
                Button{
                    action()
                } label: {
                        HStack{
                            icon
                            Text(name).bold()
                        }
                    
                }.frame(maxWidth: .infinity).padding(.horizontal)
            .padding(.vertical, 7)
                .background(background)
                .foregroundColor(foreground)
           
            
    }
    
}

struct SocialButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialButton(icon: Image("google"), name: "Sign in with Google", background: .red, foreground: .white){
            
        }
    }
}
