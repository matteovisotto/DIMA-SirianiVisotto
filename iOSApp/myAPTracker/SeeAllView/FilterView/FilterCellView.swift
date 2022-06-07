//
//  FilterViewCell.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 07/06/22.
//

import SwiftUI

struct FilterCellView: View {
    var title: String
    var isSelected: Bool
   var action: () -> Void
   
   init(title: String, isSelected: Bool, action: @escaping () -> Void){
       self.title = title
       self.isSelected = isSelected
       self.action = action
       UITableViewCell.appearance().backgroundColor = .clear
   }
   
   var body: some View {
       Button{
           action()
       } label: {
           HStack {
               Text(self.title).foregroundColor(Color("LabelColor"))
               Spacer()
               Image(systemName: "checkmark").foregroundColor(Color("LabelColor")).opacity(isSelected ? 1.0 : 0.0)
               
           }
       }
   }
}

