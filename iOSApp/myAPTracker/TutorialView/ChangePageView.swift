//
//  ChangePageAnimation.swift
//  APTracker
//
//  Created by Tia on 16/04/22.
//

import Foundation
import SwiftUI

struct ChangePageView: View {
    
    @State var dotState: DotState = .normal
    
    @State var dotScale: CGFloat = 1

    @State var dotRotation: Double = 0

    @State var isAnimating = false

    var currentIndex: Binding<Int>
    @State var nextIndex: Int = 1
    @State var previousIndex: Int = 0
    
    @State var tabTutorialElements: [TabTutorialElement] = tabTutorialElement
    
    @State var reachEnd: Bool = false
    var tutorialAlreadySeen: Binding<Bool>
    
    @State var pressLeft: Bool = false
    @State var pressRight: Bool = false
    
    init(_ currentIndex: Binding<Int>, _ tutorialAlreadySeen: Binding<Bool>) {
        self.currentIndex = currentIndex
        self.tutorialAlreadySeen = tutorialAlreadySeen
    }
    
    var body: some View {
        ZStack{
            ZStack{
                (dotState == .normal ? tabTutorialElement[currentIndex.wrappedValue].color :
                                tabTutorialElement[nextIndex].color)
                if dotState == .normal {
                    SampleTutorialView($tabTutorialElements[currentIndex.wrappedValue])
                }
                else{

                    if (pressRight){
                        SampleTutorialView($tabTutorialElements[nextIndex])
                    }
                }
            }
            .animation(.none, value: dotState)
            
            Rectangle()
                .fill(!reachEnd ? (dotState != .normal ? tabTutorialElement[currentIndex.wrappedValue].color :
                                    tabTutorialElement[nextIndex].color) : Color("BackgroundColor"))
                .overlay(
                    ZStack{
                        if dotState == .normal {
                            SampleTutorialView($tabTutorialElements[currentIndex.wrappedValue])
                        }
                        else{
                            if (pressRight){
                                SampleTutorialView($tabTutorialElements[nextIndex])
                            }
                        }
                    }
                )
                .animation(.none, value: dotState)
                
                .mask(GeometryReader{ proxy in
                    Circle()
                        .frame(width: 50, height: 50)
                        .scaleEffect(dotScale)
                        .rotation3DEffect(.init(degrees: dotRotation),
                                          axis: (x: 0, y: 1, z: 0),
                                          anchorZ: dotState == .flipped ? -10 : 10,
                                          perspective: 1)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .bottomTrailing)
                        .offset (x: -20, y: -(getSafeArea().bottom + 20))
                    }
                )
                
            Circle()
                .foregroundColor(Color.black.opacity(0.01))
                .frame (width: 50, height: 50)
                .overlay(
                    Image(systemName: reachEnd ? "checkmark" : "arrow.right")
                        .resizable()
                        .frame(width: 18, height: 18)
                        //.foregroundColor(Color("BackgroundColorInverse"))
                        .foregroundColor(Color(currentIndex.wrappedValue == 0 ? "BackgroundColor" : "BackgroundColorInverse"))
                        .opacity(dotRotation == -180 ? 0 : 1)
                        .animation(.easeInOut,
                                   value: dotRotation)
                )
                .frame (maxWidth: .infinity, maxHeight:
                        .infinity, alignment: .bottomTrailing)
                .onTapGesture (perform: {
                    pressRight = true
                    pressLeft = false
                    
                    if isAnimating {return}
                    
                    if reachEnd {
                        PreferenceManager.shared.setTutorialAlreadySeen(true)
                        tutorialAlreadySeen.wrappedValue = true
                        
                        return
                    }
                    
                    isAnimating = true
            
                    withAnimation(.linear(duration: 1.5)){
                        dotRotation = -180
                        dotScale = 8
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.725) {
                        withAnimation(.easeInOut(duration: 0.71)){
                            dotState = .flipped
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.easeInOut(duration: 0.5)){
                            dotScale = 1
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now () + 1.3) {
                        
                        withAnimation(.easeInOut(duration: 0.5)){
                            dotRotation = 0
                            dotState = .normal
                            previousIndex = currentIndex.wrappedValue
                            currentIndex.wrappedValue = nextIndex
                            if (nextIndex != tabTutorialElement.count - 1) {
                                nextIndex = nextIndex + 1
                            } else {
                                reachEnd = true;
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isAnimating = false
                            pressRight = false
                            pressLeft = false
                        }
                        
                    }
                })
                .offset (x: -20, y: -(getSafeArea().bottom + 20))
            
        }
        .ignoresSafeArea()
    }
}

struct ChangePage_Previews: PreviewProvider {
    static var previews: some View {
        ChangePageView(.constant(0), .constant(false))
    }
}

enum DotState {
    case normal
    case flipped
}
