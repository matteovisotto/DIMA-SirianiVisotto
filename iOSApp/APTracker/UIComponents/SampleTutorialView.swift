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
                .aspectRatio(contentMode: .fit)
                .padding(40)
            VStack(alignment: .leading, spacing: 0) {
                Text(tab.wrappedValue.title)
                    .font(.system(size: 40))
                Text(tab.wrappedValue.description)
                    .font(.system(size: 50, weight: .bold))
                Text(tab.wrappedValue.title)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .frame(width: getRect().width - 100, alignment: .leading)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.trailing, .top])
        }
    }
}
