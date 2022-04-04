//
//  LoginVIew.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        VStack{
            Spacer()
            VStack{
                TextField("Email", text: $viewModel.email).textFieldStyle(.roundedBorder).keyboardType(.emailAddress)
                SecureField("Password", text: $viewModel.password).textFieldStyle(.roundedBorder)
                Button{
                    
                } label: {
                        HStack{
                            Image(systemName: "lock.fill")
                            Text("Login").bold()
                        }
                    
                }.frame(maxWidth: .infinity).padding(.horizontal)
            .padding(.vertical, 7)
            .background(Color.orange)
            .foregroundColor(Color.white)
                
            }.padding()
            //Spacer()
            ZStack{
                Divider().frame(height: 1.5)
                Text("OR").padding(.horizontal,5).background(Color("BackgroundColor"))
            }.padding(.horizontal)
            HStack{
                SocialButton(icon: Image("google"), name: "Sign in with Google", background: .red, foreground: .white) {
                    viewModel.authWithGoogle()
                }
                SocialButton(icon: Image("facebook"), name: "Sign in with Facebook", background: Color("FacebookColor"), foreground: .white) {
                    
                }
            }.padding(.horizontal)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
