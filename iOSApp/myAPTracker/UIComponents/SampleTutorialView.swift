//
//  SampleTutorialView.swift
//  APTracker
//
//  Created by Tia on 16/04/22.
//

import Foundation
import SwiftUI

struct SampleTutorialView: View {
    
    var tab: Binding<TabTutorialElement>
    
    init(_ tab: Binding<TabTutorialElement>) {
        self.tab = tab
    }
    
    var body: some View {
        VStack(spacing: 10){
            Image(systemName: tab.wrappedValue.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(tab.wrappedValue.fontColor)
                .padding()
            VStack(alignment: .leading, spacing: 0) {
                Text(tab.wrappedValue.subtitle)
                    .font(.system(size: 40))
                Text(tab.wrappedValue.title)
                    .font(.system(size: 50, weight: .bold))
                Text(tab.wrappedValue.description)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .frame(width: getRect().width - 100, alignment: .leading)
            }
            .foregroundColor(tab.wrappedValue.fontColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.trailing, .top])
        }
    }
}


struct SampleTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("Tutorial1").ignoresSafeArea()
            SampleTutorialView(.constant(TabTutorialElement(id: UUID().uuidString, title: "myAPTracker", subtitle: "Welcome in", description: "Keep track of your favourite Amazon product", image: "person.fill", color: Color("Tutorial2"), fontColor: Color("Tutorial3"))))
        }
    }
}

