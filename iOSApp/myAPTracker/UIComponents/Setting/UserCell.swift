//
//  UserCell.swift
//  APTracker
//
//  Created by Matteo Visotto on 08/04/22.
//

import SwiftUI

struct UserCell: View {
    var userIdentity: UserIdentity?
    var body: some View {
        HStack{
            UserWebImage("https://avatars.dicebear.com/api/initials/"+Utils.getInitialFromIdentity(userIdentity)+".png")
                .frame(width: 55, height: 55, alignment: .center).cornerRadius(55/2)
                .padding(.trailing, 5)
            VStack(alignment: .leading){
                Text((userIdentity?.name ?? "") + " " + (userIdentity?.surname ?? "")).font(.title2)
                //Text("Nome e Cognome").font(.title2)
                Text(userIdentity?.email ?? "")
                
            }
        }.foregroundColor(Color("PrimaryLabel"))
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(userIdentity: UserIdentity(id: 0, name: "Matteo", surname: "Visotto", email: "matteo.visotto@mail.polimi.it", username: "matteovisotto", createdAt: ""))
    }
}
