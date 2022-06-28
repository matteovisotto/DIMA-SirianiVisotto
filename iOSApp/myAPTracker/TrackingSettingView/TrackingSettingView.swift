//
//  TrackingSettingView.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import SwiftUI

struct TrackingSettingView: View {
        @Environment(\.presentationMode) var mode: Binding<PresentationMode>
        @ObservedObject var viewModel = TrackingSettingViewModel()
    
        init() {
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
                        HStack{
                            Button{
                                mode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrow.left").font(.title3.bold())
                            }.foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                        }
                        Spacer().frame(height: 8)
                        HStack{
                            Text("Product notification").font(.largeTitle.bold()).foregroundColor(Color("PrimaryLabel"))
                            Spacer()
                        }
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 10){
                                Text("You can choose the default settings to receive notifications about your tracked products when the price drops.").foregroundColor(Color("PrimaryLabel")).font(.callout)
                                Text("This setting can be overridden for each product you track by opening the product page").foregroundColor(Color("PrimaryLabel")).font(.caption)
                                Group{
                                    Picker("", selection: $viewModel.dropKey) {
                                        Text("Never").tag("none").accessibilityIdentifier("NeverSettingsPicker")
                                        Text("Percentage").tag("percentage").accessibilityIdentifier("PercentageSettingsPicker")
                                        Text("Value").tag("value").accessibilityIdentifier("ValueSettingsPicker")
                                        //Text("Price").tag("price")
                                        Text("Always").tag("always").accessibilityIdentifier("AlwaysSettingsPicker")
                                    }.pickerStyle(.segmented).padding(.vertical)
                                    if(viewModel.dropKey == "percentage") {
                                        CircularSlider($viewModel.dropValuePercentage).frame(width: 150, height: 150, alignment: .center).accessibilityIdentifier("CircularSliderCustomView")
                                    }
                                    if (viewModel.dropKey == "value") {
                                        PickerView($viewModel.dropValue, 200).frame(height: 150)
                                            .accessibilityIdentifier("PickerCustomView")
                                    }
                                    switch viewModel.dropKey {
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
                                        Text("You can choose the default settings to receive notifications about comments in your tracked products.").foregroundColor(Color("PrimaryLabel")).font(.callout)
                                        Text("This setting can be overridden for each product you track by opening the product page").foregroundColor(Color("PrimaryLabel")).font(.caption)
                                        Picker("", selection: $viewModel.commentPolicy) {
                                            Text("Never").tag("never").accessibilityIdentifier("NeverCommentButton")
                                            Text("Always").tag("always").accessibilityIdentifier("AlwaysCommentButton")
                                        }.pickerStyle(.segmented).padding(.vertical)
                                    }
                                    HStack{
                                        Spacer()
                                        Button{
                                            viewModel.saveSetting(percentage: viewModel.dropKey == "percentage")
                                        } label: {
                                            Text("Change").bold()
                                                .padding(.vertical, 3)
                                        }.frame(width: (geom.size.width-40)/2)
                                            .accessibilityIdentifier("ChangeSettingsTrackingButton")
                                    .padding(.vertical, 7)
                                    .background(Color("Primary"))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(15)
                                    .disabled(!viewModel.validateSettings())
                                    .opacity(!viewModel.validateSettings() ? 0.5 : 1)
                                    }.padding(.top)
                                }
                                
            
                            }.padding(.vertical, 5)
                        }
                    }.padding()
                }.onAppear {
                    viewModel.loadData()
                }
                
            }.navigationBarHidden(true)
        }
    
}

struct TrackingSettingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingSettingView()
    }
}
