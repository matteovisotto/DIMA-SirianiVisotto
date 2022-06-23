//
//  UserProfileView.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel = UserProfileViewModel()
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            GeometryReader{ geom in
                ScrollView(.vertical, showsIndicators: false) {
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
                                .accessibilityIdentifier("ProfileText")
                            Spacer()
                        }
                        VStack(spacing: 10){
                            IconTextField(titleKey: "Name", text: $viewModel.name, icon: Image(systemName: "person"), foregroundColor: Color("PrimaryLabel")) { text in
                                return !(text.isEmpty || text == "")
                            }
                            IconTextField(titleKey: "Surname", text: $viewModel.surname, icon: Image(systemName: "person"), foregroundColor: Color("PrimaryLabel")) { text in
                                return !(text.isEmpty || text == "")
                            }
                            IconTextField(titleKey: "Username", text: $viewModel.username, icon: Image(systemName: "person"), foregroundColor: Color("PrimaryLabel")) { text in
                                return !(text.isEmpty || text == "")
                            }
                            HStack{
                                Spacer()
                                Button{
                                    viewModel.updateProfile()
                                } label: {
                                    Text("Save").bold()
                                        .padding(.vertical, 3)
                                    
                                }.frame(width: (geom.size.width-40)/2)
                            .padding(.vertical, 7)
                            .background(Color("Primary"))
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                            .disabled(!viewModel.validateUserData())
                            .opacity(!viewModel.validateUserData() ? 0.5 : 1)
                            }
                            .padding(.top)
                            Collapsible {
                                Text("Change password")
                            } content: {
                                VStack(spacing: 10){
                                    IconSecureTextField(titleKey: "Old Password", text: $viewModel.oldPassword, icon: Image(systemName: "lock"), foregroundColor: Color("PrimaryLabel"))
                                    IconSecureTextField(titleKey: "Password", text: $viewModel.password, icon: Image(systemName: "lock"), foregroundColor: Color("PrimaryLabel"))
                                    IconSecureTextField(titleKey: "Confirm password", text: $viewModel.passwordCnf, icon: Image(systemName: "lock"), foregroundColor: Color("PrimaryLabel"))
                                    Text("If you have created your account using socials, you need to reset your password to enable APTracker local login").font(.caption)
                                    HStack{
                                        Spacer()
                                        Button{
                                            viewModel.changePassword()
                                        } label: {
                                            Text("Change").bold()
                                                .padding(.vertical, 3)
                                            
                                        }.frame(width: (geom.size.width-40)/2)
                                    .padding(.vertical, 7)
                                    .background(Color("Primary"))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(15)
                                    .disabled(!viewModel.validatePassword())
                                    .opacity(!viewModel.validatePassword() ? 0.5 : 1)
                                    }
                                    .padding(.top)
                                }
                            }.padding(.top)

                            
                        }
                        Spacer()
                    }.padding()
                }
            }
            
        }.navigationBarHidden(true)
            .onAppear {
                viewModel.onAppear()
            }
    }
}

