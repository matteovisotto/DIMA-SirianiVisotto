//
//  TutorialView.swift
//  APTracker
//
//  Created by Matteo Visotto on 09/04/22.
//

import SwiftUI

struct TutorialView: View {
    //private let numberOfPages: Int = 2
    //@State var currentPage: Int = 1
    @State var currentIndex: Int = 0
    var tutorialAlreadySeen: Binding<Bool>
    
    
    init(_ tutorialAlreadySeen: Binding<Bool>) {
        self.tutorialAlreadySeen = tutorialAlreadySeen
    }
    
    var body: some View {
        ZStack {
            ChangePageView($currentIndex, tutorialAlreadySeen).ignoresSafeArea()
            HStack(spacing: 10) {
                ForEach(tabTutorialElement.indices, id: \.self) { index in
                    Circle()
                        .fill(Color("BackgroundColorInverse"))
                        .frame(width: 8, height: 8)
                        .opacity(currentIndex == index ? 1 : 0.3)
                        .scaleEffect(currentIndex == index ? 1.1 : 0.8)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(25)
            
            Button("Skip"){
                PreferenceManager.shared.setTutorialAlreadySeen(true)
                tutorialAlreadySeen.wrappedValue = true
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(Color(currentIndex == 2 ? "Tutorial1" : "Tutorial3"))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            .accessibilityIdentifier("TutorialViewSkipButton")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(.constant(false))
    }
}
