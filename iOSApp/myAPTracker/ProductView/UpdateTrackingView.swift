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
        
        init(isOpen: Binding<Bool>, status: Binding<TrackingStatus>, onSave: @escaping ()->()) {
            self.isOpen = isOpen
            self.status = status
            self.onSave = onSave
            if let v = status.wrappedValue.dropValue?.description {
                self.dropValue = v
            } else {
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
                    VStack{
                        VStack(spacing: 10){
                            Text("You can choose the settings to receive notifications about this product when the price drops.").foregroundColor(Color("PrimaryLabel")).font(.callout)
                            Text("This setting can be overridden for each product you track by opening the product page").foregroundColor(Color("PrimaryLabel")).font(.caption)
                            Group{
                                Picker("", selection: Binding(status.dropKey)!) {
                                    Text("Never").tag("none")
                                    Text("Percentage").tag("percentage")
                                    Text("Value").tag("value")
                                    //Text("Price").tag("price")
                                    Text("Always").tag("always")
                                }.pickerStyle(.segmented).padding(.vertical)
                                if(status.wrappedValue.dropKey == "percentage") {
                                    CircularSlider($dropValue).frame(width: 150, height: 150, alignment: .center)
                                }
                                if(status.wrappedValue.dropKey == "percentage"){
                                    IconTextField(titleKey: "Value", text: $dropValue, icon: Image(systemName: "percent"), foregroundColor: Color("PrimaryLabel"), showValidator: false).keyboardType(.numbersAndPunctuation)
                                }
                                if(status.wrappedValue.dropKey == "value"){
                                    IconTextField(titleKey: "Value", text: $dropValue, icon: Image(systemName: "eurosign.circle"), foregroundColor: Color("PrimaryLabel"), showValidator: false).keyboardType(.numbersAndPunctuation)
                                }
                                switch status.wrappedValue.dropKey {
                                    case "none":
                                        Text("With this option you don't receive notification for your tracked product").foregroundColor(Color("PrimaryLabel")).font(.caption)
                                    case "percentage":
                                        Text("With this option you'll receive a notification when a price falls by the defined percentage").foregroundColor(Color("PrimaryLabel")).font(.caption)
                                    case "value":
                                        Text("With this option you'll receive a notification when the price falls by the defined value").foregroundColor(Color("PrimaryLabel")).font(.caption)
                                    case "price":
                                        Text("With this option you'll receive a notification when the price falls below the defined import").foregroundColor(Color("PrimaryLabel")).font(.caption)
                                    case "always":
                                        Text("With this option you'll receive a notification every time the price falls").foregroundColor(Color("PrimaryLabel")).font(.caption)
                                    default:
                                        EmptyView()
                                }
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
                                        status.dropValue.wrappedValue = Double(self.dropValue)
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
                                //.disabled(!viewModel.validateSettings())
                                //.opacity(!viewModel.validateSettings() ? 0.5 : 1)
                                }.padding(.top)
                            }
                            
        
                        }.padding(.vertical, 5)
                    }.padding()
                
                }
                
            }.navigationBarHidden(true)
        }
    
}
