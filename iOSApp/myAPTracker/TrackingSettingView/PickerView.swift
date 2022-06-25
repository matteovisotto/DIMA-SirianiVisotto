//
//  PickerView.swift
//  myAPTracker
//
//  Created by Tia on 12/05/22.
//

import SwiftUI

struct PickerView: View {
    
    @State var firstPartSelection = 0
    @State var secondPartSelection = 0
    let price: Double
    @State var setup: Bool = true
    
    var stringValue: Binding<String>
    
    init(_ valuePercentage: Binding<String>,_ price: Double) {
        self.stringValue = valuePercentage
        self.price = price
    }
    
    var body: some View {
        let valueText = Binding<Double> (
            get: {
                Double(stringValue.wrappedValue) ?? 0.0
            },
            set: {
                stringValue.wrappedValue = "\($0)"
            }
        )
        GeometryReader{ geom in
            HStack(spacing: 0) {
                Picker(selection: self.$firstPartSelection, label: Text("")) {
                    ForEach(0...Int(price * 2), id: \.self) { index in
                        Text("\(index)").tag(index)
                        }
                }
                .onChange(of: self.firstPartSelection) { tag in
                    let temp = Double(self.$secondPartSelection.wrappedValue) / 100
                    valueText.wrappedValue = Double(self.$firstPartSelection.wrappedValue) + temp
                }
                .pickerStyle(.wheel)
                    .frame(width: geom.size.width/2, height: geom.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                    .accessibilityIdentifier("PickerViewFirstPicker")
                Picker(selection: self.$secondPartSelection, label: Text("")) {
                    ForEach(0...99, id: \.self) { index in
                        Text("\(index)").tag(index)
                        }
                }
                .pickerStyle(.wheel)
                    .frame(width: geom.size.width/2, height: geom.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                    .onChange(of: self.secondPartSelection) { tag in
                        let temp = Double(self.$secondPartSelection.wrappedValue) / 100
                        valueText.wrappedValue = Double(self.$firstPartSelection.wrappedValue) + temp
                    }
                    .accessibilityIdentifier("PickerViewSecondPicker")
            }.onAppear(perform: {
                firstPartSelection = Int(valueText.wrappedValue)
                secondPartSelection = Int(valueText.wrappedValue.truncatingRemainder(dividingBy: 1)*100)
            })
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(.constant("12.22"), 12.22)
    }
}
