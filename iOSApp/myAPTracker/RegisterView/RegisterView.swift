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
    
    @ObservedObject var viewModel: RegisterViewModel
    
    init() {
        self.viewModel = RegisterViewModel()
    }
    
    var body: some View {
        ZStack{
            GeometryReader{geom in
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
                            .accessibilityIdentifier("RegisterViewRegisterText")
                        Spacer()
                    }
                    VStack(spacing: 10){
                        IconTextField(titleKey: "Name", text: $viewModel.name, icon: Image(systemName: "person"), foregroundColor: Color("PrimaryLabel")) { text in
                            return !(text.isEmpty || text == "")
                        }.accessibilityIdentifier("RegisterViewNameTextField")
                        IconTextField(titleKey: "Surname", text: $viewModel.surname, icon: Image(systemName: "person"), foregroundColor: Color("PrimaryLabel")) { text in
                            return !(text.isEmpty || text == "")
                        }.accessibilityIdentifier("RegisterViewSurnameTextField")
                        IconTextField(titleKey: "email", text: $viewModel.email, icon: Image(systemName: "at"), foregroundColor: Color("PrimaryLabel")) { text in
                            return viewModel.isValidEmail(text)
                        }.autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .accessibilityIdentifier("RegisterViewEmailTextField")
                        IconSecureTextField(titleKey: "Password", text: $viewModel.password, icon: Image(systemName: "lock"), foregroundColor: Color("PrimaryLabel")).accessibilityIdentifier("RegisterViewPasswordTextField")
                        IconSecureTextField(titleKey: "Confirm password", text: $viewModel.passwordCnf, icon: Image(systemName: "lock"), foregroundColor: Color("PrimaryLabel")).accessibilityIdentifier("RegisterViewPasswordConfTextField")
                        Toggle(isOn: $viewModel.termsAndCondition) {
                            Text("Accept terms and condition").foregroundColor(Color("PrimaryLabel"))
                        }.padding(.horizontal).padding(.top)
                            .toggleStyle(SwitchToggleStyle(tint: Color("Primary")))
                            .accessibilityIdentifier("RegisterViewToggle")
                        HStack{
                            Spacer()
                            Button{
                                viewModel.register()
                            } label: {
                                Text("Register").bold()
                                    .padding(.vertical, 3)
                                
                            }.frame(width: (geom.size.width-40)/2)
                                .accessibilityIdentifier("RegisterViewRegisterButton")
                        .padding(.vertical, 7)
                        .background(Color("Primary"))
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                        .disabled(viewModel.isFormInvalid())
                        .opacity(viewModel.isFormInvalid() ? 0.5 : 1)
                        }
                        .padding(.top)
                    }
                    Spacer()
                }.padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
           
            }
            
        }.viewBackground(Color("BackgroundColor")).navigationBarHidden(true).ignoresSafeArea().onAppear {
            viewModel.presentationMode = mode
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
