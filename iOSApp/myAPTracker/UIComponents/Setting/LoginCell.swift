//
//  LoginCell.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import SwiftUI

struct LoginCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Do you know how many thing you can do with an account?").font(.subheadline)
            Text("Login or create your account").font(.body.bold()).foregroundColor(Color("Primary"))
                .accessibilityIdentifier("LoginOrCreateAnAccountButton")
        }.foregroundColor(Color("PrimaryLabel"))
    }
}

struct LoginCell_Previews: PreviewProvider {
    static var previews: some View {
        LoginCell().padding(.horizontal, 25)
    }
}

