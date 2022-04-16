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
    
    /*init(_ tutorialAlreadySeen: Binding<Bool>) {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "PrimaryLabel")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "PrimaryLabel")!.withAlphaComponent(0.7)
        self.tutorialAlreadySeen = tutorialAlreadySeen
    }
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            TabView(selection: $currentPage){
                Text("Step 1").tag(1)
                Text("Step 2").tag(2)
            }.tabViewStyle(.page)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        let c = self.currentPage
                        if(c == numberOfPages){
                            PreferenceManager.shared.setTutorialAlreadySeen(true)
                            tutorialAlreadySeen.wrappedValue = true
                        } else {
                            self.currentPage = self.currentPage + 1
                        }
                    } label: {
                        Image(systemName: self.currentPage == self.numberOfPages ? "checkmark" : "arrow.right")
                    }
                    .frame(width: 45, height: 45)
                    .background(Color("Primary"))
                    .foregroundColor(Color.white)
                    .font(.callout)
                    .cornerRadius(45/2)
                    .padding()
                    
                }
            }
        }
    }*/
    
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
                tutorialAlreadySeen.wrappedValue = true
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(Color("BackgroundColorInverse"))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(.constant(false))
    }
}
