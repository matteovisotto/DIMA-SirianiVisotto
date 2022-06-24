//
//  AppTabBar.swift
//  APTracker
//
//  Created by Matteo Visotto on 07/04/22.
//

import SwiftUI

struct AppTabBar: View {
    @Binding var selectedTab: Int
    var elements: [TabElement]
    var centralButtonAction: () -> ()
    var body: some View {
        GeometryReader { geometry in
            HStack {
           
                Button{
                    selectedTab = elements[0].tag
                } label: {
                    VStack{
                        Image(systemName: elements[0].iconSystemName)
                        Circle().fill(Color("Primary")).frame(width: 5, height: 5, alignment: .center).opacity(selectedTab == elements[0].tag ? 1 : 0)
                    }
                }.frame(width: geometry.size.width/5).foregroundColor(selectedTab == elements[0].tag ? Color("PrimaryLabel") : Color("PrimaryLabel").opacity(0.5))
                    .accessibilityIdentifier("HomeTabBar")
                Spacer()
                Button{
                    selectedTab = elements[1].tag
                } label: {
                    VStack{
                        Image(systemName: elements[1].iconSystemName)
                        Circle().fill(Color("Primary")).frame(width: 5, height: 5, alignment: .center).opacity(selectedTab == elements[1].tag ? 1 : 0)
                    }
                }.frame(width: geometry.size.width/5).foregroundColor(selectedTab == elements[1].tag ? Color("PrimaryLabel") : Color("PrimaryLabel").opacity(0.5))
                    .accessibilityIdentifier("TrackingTabBar")
                Spacer()
                Button{
                    centralButtonAction()
                } label: {
                    Image(systemName: "plus")
                }.buttonStyle(PlainButtonStyle())
                    .padding(12)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .offset(y: -20)
                    .accessibilityIdentifier("AmazonTabBar")
                    
                Spacer()
                Button{
                    selectedTab = elements[2].tag
                } label: {
                    VStack{
                        Image(systemName: elements[2].iconSystemName)
                        Circle().fill(Color("Primary")).frame(width: 5, height: 5, alignment: .center).opacity(selectedTab == elements[2].tag ? 1 : 0)
                    }
                }.frame(width: geometry.size.width/5).foregroundColor(selectedTab == elements[2].tag ? Color("PrimaryLabel") : Color("PrimaryLabel").opacity(0.5))
                    .accessibilityIdentifier("ExploreTabBar")
                Spacer()
                
                Button{
                    selectedTab = elements[3].tag
                } label: {
                    VStack{
                        Image(systemName: elements[3].iconSystemName)
                        Circle().fill(Color("Primary")).frame(width: 5, height: 5, alignment: .center).opacity(selectedTab == elements[3].tag ? 1 : 0)
                    }
                }.frame(width: geometry.size.width/5).foregroundColor(selectedTab == elements[3].tag ? Color("PrimaryLabel") : Color("PrimaryLabel").opacity(0.5))
                    .accessibilityIdentifier("SettingsTabBar")
                
            }
        }
    }
}
