//
//  UserProfileView.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            VStack{
                HStack{
                    Button{
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left").font(.title3.bold())
                    }.foregroundColor(Color("PrimaryLabel"))
                    Spacer()
                }
                Spacer().frame(height: 8)
                HStack{
                    Text("Profile").font(.largeTitle.bold()).foregroundColor(Color("PrimaryLabel"))
                    Spacer()
                }
                Spacer() //Content Here
            }.padding()
        }.navigationBarHidden(true)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
