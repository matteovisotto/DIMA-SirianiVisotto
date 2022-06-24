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
    
    private func scaleImage(_ screenSize: CGSize) -> CGFloat {
        let otherContent = 568*(1-1/3.5)
        let maxDimension = screenSize.height - otherContent
        return min(screenSize.width-60, maxDimension)
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                GeometryReader{ geom in
                    VStack{
                        Image("login-image").resizable().frame(width: scaleImage(geom.size), height: scaleImage(geom.size), alignment: .center)
                    
                        VStack{
                            HStack{
                                Text("Login").font(.largeTitle.bold()).foregroundColor(Color("PrimaryLabel"))
                                    .accessibilityIdentifier("LoginViewLoginText")
                                Spacer()
                            }
                            
                            IconTextField(titleKey: "Email", text: $viewModel.email, icon: Image(systemName: "at"), foregroundColor: Color("PrimaryLabel")) { text in
                                return viewModel.isValidEmail(text)
                            }.autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .accessibilityIdentifier("LoginViewEmailTextField")
                            IconSecureTextField(titleKey: "Password", text: $viewModel.password, icon: Image(systemName: "lock"), foregroundColor: Color("PrimaryLabel")).accessibilityIdentifier("LoginViewPasswordTextField")
                                
                            HStack{
                                Spacer()
                                Button{
                                    viewModel.authLocal()
                                } label: {
                                    Text("Login").bold()
                                        .padding(.vertical, 3)
                                    
                                }.frame(width: (geom.size.width-40)/2)
                                    .accessibilityIdentifier("LoginViewLoginButton")
                            .padding(.vertical, 7)
                            .background(Color("Primary"))
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                            .disabled(viewModel.isNotCredentialInserted())
                            .opacity(viewModel.isNotCredentialInserted() ? 0.5 : 1)
                            }
                            .padding(.top)
                            
                        }.padding()
                        //Spacer()
                        ZStack{
                            Divider().frame(height: 1.5)
                            Text("OR").padding(.horizontal,5).background(Color("BackgroundColor"))
                        }.padding(.horizontal)
                        
                        HStack(spacing: 20){
                            Spacer()
                            SocialSmallButton(icon: Image("google-logo"), borderColor: Color("PrimaryLabel")) {
                                viewModel.authWithGoogle()
                            }
                            
                            SocialSmallButton(icon: Image("apple-logo"), borderColor: Color("PrimaryLabel")
                            ) {
                                viewModel.authWithApple()
                            }
                            
                            SocialSmallButton(icon: Image("facebook-logo"), borderColor: Color("PrimaryLabel")) {
                                viewModel.authWithFacebook()
                            }
                            
                            Spacer()
                        }.frame(maxWidth: .infinity, maxHeight: 55)
                            .padding(.horizontal)
                        HStack{
                            Spacer()
                            Text("Alternatively").foregroundColor(Color("PrimaryLabel"))
                            NavigationLink {
                                RegisterView()
                            } label: {
                                Text("Register Here")
                            }
                            .foregroundColor(Color("Primary"))
                            .accessibilityIdentifier("LoginViewRegisterButton")
                        Spacer()
                        }.padding(.top, 10)
                            .font(.subheadline.bold())
                    }
                    }
                    Button{
                        viewModel.dismiss()
                    } label: {
                        Image(systemName: "xmark").font(.title3.bold())
                    }.foregroundColor(Color("PrimaryLabel"))
                        .toTopLeft()
                    if(viewModel.isLoading){
                        ZStack{
                            Color("LabelColor").opacity(0.4)
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("BackgroundColor"))).scaleEffect(x: 2, y: 2, anchor: .center)
                        }.ignoresSafeArea()
                    }
                }.navigationBarHidden(true)
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(.constant(true))
    }
}
