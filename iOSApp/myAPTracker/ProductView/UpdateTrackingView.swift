//
//  UpdateTrackingView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI

struct UpdateTrackingView: View {
        
        var status: Binding<TrackingStatus>
        var isOpen: Binding<Bool>
        var onSave: () -> ()
        @State var dropValue: String
        @State var dropValuePercentage: String
        var price: Double
        
    init(isOpen: Binding<Bool>, price: Double, status: Binding<TrackingStatus>, onSave: @escaping ()->()) {
            self.isOpen = isOpen
            self.status = status
            self.onSave = onSave
            self.price = price
            if (status.wrappedValue.dropKey?.description == "percentage") {
                if let v = status.wrappedValue.dropValue?.description {
                    self.dropValuePercentage = v
                    self.dropValue = "0.0"
                } else {
                    self.dropValuePercentage = "0.0"
                    self.dropValue = "0.0"
                }
            } else if (status.wrappedValue.dropKey?.description == "value") {
                if let v = status.wrappedValue.dropValue?.description {
                    self.dropValuePercentage = "0.0"
                    self.dropValue = v
                } else {
                    self.dropValuePercentage = "0.0"
                    self.dropValue = "0.0"
                }
            } else {
                self.dropValuePercentage = "0.0"
                self.dropValue = "0.0"
            }
            UISegmentedControl.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.2)
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "Primary")
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "PrimaryLabel") ?? .black], for: .normal)
        }
        
        var body: some View {
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                GeometryReader{ geom in
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            VStack(spacing: 10){
                                Text("You can choose the settings to receive notifications about this product when the price drops.").foregroundColor(Color("PrimaryLabel")).font(.callout).accessibilityIdentifier("UpdateTrackingViewNotificationText")
                                Text("This setting can be overridden for each product you track by opening the product page").foregroundColor(Color("PrimaryLabel")).font(.caption)
                                Group{
                                    Picker("", selection: Binding(status.dropKey)!) {
                                        Text("Never").tag("none").accessibilityIdentifier("UpdateTrackingViewNeverButton")
                                        Text("Percentage").tag("percentage").accessibilityIdentifier("UpdateTrackingViewPercentageButton")
                                        Text("Value").tag("value").accessibilityIdentifier("UpdateTrackingViewValueButton")
                                        Text("Always").tag("always").accessibilityIdentifier("UpdateTrackingViewAlwaysButton")
                                    }.pickerStyle(.segmented).padding(.vertical)
                                    if(status.wrappedValue.dropKey == "percentage") {
                                        CircularSlider($dropValuePercentage).frame(width: 150, height: 150, alignment: .center)
                                    } else if (status.wrappedValue.dropKey == "value") {
                                        PickerView($dropValue, price).frame(height: 150)
                                    }
                                    switch status.wrappedValue.dropKey {
                                        case "none":
                                        Text("With this option you don't receive notification for your tracked product").foregroundColor(Color("PrimaryLabel")).font(.caption).accessibilityIdentifier("UpdateTrackingViewNeverNotificationText")
                                        case "percentage":
                                            Text("With this option you'll receive a notification when a price falls by the defined percentage").foregroundColor(Color("PrimaryLabel")).font(.caption).accessibilityIdentifier("UpdateTrackingViewPercentageNotificationText")
                                        /*case "value":
                                            Text("With this option you'll receive a notification when the price falls by the defined value").foregroundColor(Color("PrimaryLabel")).font(.caption).accessibilityIdentifier("UpdateTrackingViewValueNotificationText")*/
                                        case "value":
                                            Text("With this option you'll receive a notification when the price falls below the defined import").foregroundColor(Color("PrimaryLabel")).font(.caption).accessibilityIdentifier("UpdateTrackingViewValueNotificationText")
                                        case "always":
                                            Text("With this option you'll receive a notification every time the price falls").foregroundColor(Color("PrimaryLabel")).font(.caption).accessibilityIdentifier("UpdateTrackingViewAlwaysNotificationText")
                                        default:
                                            EmptyView()
                                    }
                                    Spacer().frame(height: 10)
                                    Group{
                                        Text("You can choose if receive or not notification about comments on this product.").foregroundColor(Color("PrimaryLabel")).font(.callout)
                                        Picker("", selection: Binding(status.commentPolicy)!) {
                                            Text("Never").tag("never")
                                            Text("Always").tag("always")
                                        }.pickerStyle(.segmented).padding(.vertical)
                                    }
                                    HStack{
                                        Spacer()
                                        Button{
                                            if (status.dropKey.wrappedValue == "percentage"){
                                                status.dropValue.wrappedValue = Double(self.dropValuePercentage)
                                            } else if (status.dropKey.wrappedValue == "value"){
                                                status.dropValue.wrappedValue = Double(self.dropValue)
                                            }
                                            self.onSave()
                                            self.isOpen.wrappedValue = false
                                        } label: {
                                            Text("Change").bold()
                                                .padding(.vertical, 3)
                                            
                                        }.frame(width: (geom.size.width-40)/2)
                                    .padding(.vertical, 7)
                                    .background(Color("Primary"))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(15)
                                    }.padding(.top)
                                }
                                
                            }.padding(.vertical, 5)
                        }.padding()
                    }
                
                }
                
            }.navigationBarHidden(true)
        }
    
}
