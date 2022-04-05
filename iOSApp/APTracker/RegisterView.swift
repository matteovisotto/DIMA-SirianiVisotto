//
//  RegisterView.swift
//  APTracker
//
//  Created by Matteo Visotto on 05/04/22.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        ZStack{
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
                        Text("Register").font(.largeTitle.bold()).foregroundColor(Color("PrimaryLabel"))
                        Spacer()
                    }
                    
                    Spacer()
                    Button{
                        AppState.shared.riseError(title: "", message: "")
                    } label: {
                        Text("Display error")
                    }
                }.padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
           
            
        }.viewBackground(Color("BackgroundColor")).navigationBarHidden(true).ignoresSafeArea()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
