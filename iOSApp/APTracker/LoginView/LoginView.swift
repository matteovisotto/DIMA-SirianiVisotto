//
//  LoginVIew.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel:LoginViewModel
    
    init(_ isPresented: Binding<Bool>){
        self.viewModel = LoginViewModel(isPresented)
    }
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                VStack{
                    
                        // Fallback on earlier versions
                        TextField("Email", text: $viewModel.email).textFieldStyle(.roundedBorder).keyboardType(.emailAddress).autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password).textFieldStyle(.roundedBorder)
                    Button{
                        viewModel.authLocal()
                    } label: {
                            HStack{
                                Image(systemName: "lock.fill")
                                Text("Login").bold()
                            }
                        
                    }.frame(maxWidth: .infinity).padding(.horizontal)
                .padding(.vertical, 7)
                .background(Color.orange)
                .foregroundColor(Color.white)
                .disabled(viewModel.isNotCredentialInserted())
                    
                }.padding()
                //Spacer()
                ZStack{
                    Divider().frame(height: 1.5)
                    Text("OR").padding(.horizontal,5).background(Color("BackgroundColor"))
                }.padding(.horizontal)
                
                HStack(spacing: 20){
                    Spacer()
                    SocialSmallButton(icon: Image("google-logo"), borderColor: Color("BackgroundColorInverse")) {
                        viewModel.authWithGoogle()
                    }
                    
                    SocialSmallButton(icon: Image("apple-logo"), borderColor: Color("BackgroundColorInverse")
                    ) {
                        viewModel.authWithApple()
                    }
                    
                    SocialSmallButton(icon: Image("facebook-logo"), borderColor: Color("BackgroundColorInverse")) {
                        viewModel.authWithFacebook()
                    }
                    
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: 55)
                    .padding(.horizontal)
                    
                Spacer()
            }
            Button{
                viewModel.dismiss()
            } label: {
                Image(systemName: "xmark").font(.title3.bold())
            }.foregroundColor(Color("BackgroundColorInverse"))
                .toTopLeft()
            if(viewModel.isLoading){
                ZStack{
                    Color("LabelColor").opacity(0.4)
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("BackgroundColor"))).scaleEffect(x: 2, y: 2, anchor: .center)
                }.ignoresSafeArea()
            }
        }.viewBackground(Color("BackgroundColor")).ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(.constant(true))
    }
}
