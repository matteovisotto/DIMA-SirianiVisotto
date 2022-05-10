//
//  CircularSlider.swift
//  myAPTracker
//
//  Created by Tia on 10/05/22.
//

import Foundation
import SwiftUI

struct CircularSlider: View {
    @State var angleValue: CGFloat = 0.0
    
    var stringValue: Binding<String>
    let config = Config(minimumValue: 0.0,
                        maximumValue: 100.0,
                        totalValue: 100.0,
                        knobRadius: 9,
                        radius: 75)
    
    init(_ valuePercentage: Binding<String>) {
        self.stringValue = valuePercentage
    }
    
    var body: some View {
        let valuePercentage = Binding<Double> (
            get: {
                Double(stringValue.wrappedValue) ?? 0.0
            },
            set: {
                stringValue.wrappedValue = "\($0)"
            }
        )
        
        ZStack {
            Circle()
                .stroke(Color("BackgroundColor"))
                .frame(width: config.radius * 2, height: config.radius * 2)
                .scaleEffect(1.2)
            
            Circle()
                .stroke(Color("PrimaryLabel"),
                        style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [3, 23.18]))
                .frame(width: config.radius * 2, height: config.radius * 2)
            
            Circle()
                .trim(from: 0.0, to: valuePercentage.wrappedValue/config.totalValue)
                .stroke(Color("PrimaryLabel"), lineWidth: 4)
                .frame(width: config.radius * 2, height: config.radius * 2)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .fill(Color("BackgroundColorInverse"))
                .frame(width: config.knobRadius * 2, height: config.knobRadius * 2)
                .padding(10)
                .offset(y: -config.radius)
                .rotationEffect(Angle.degrees(Double(angleValue)))
                .gesture(DragGesture(minimumDistance: 0.0)
                            .onChanged({ value in
                                change(location: value.location, valuePercentage: valuePercentage)
                            }))
            
            Text("\(String.init(format: "%.0f", valuePercentage.wrappedValue)) %")
                            .font(.system(size: 40))
        }
    }
    
    private func change(location: CGPoint, valuePercentage: Binding<Double>) {
        let vector = CGVector(dx: location.x, dy: location.y)
        
        let angle = atan2(vector.dy - (config.knobRadius + 10), vector.dx - (config.knobRadius + 10)) + .pi/2.0
        
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        let value = fixedAngle / (2.0 * .pi) * config.totalValue
        
        if (value >= config.minimumValue && value <= config.maximumValue) {
            valuePercentage.wrappedValue = value
            angleValue = fixedAngle * 180 / .pi
        }
    }
}

struct Config {
    let minimumValue: CGFloat
    let maximumValue: CGFloat
    let totalValue: CGFloat
    let knobRadius: CGFloat
    let radius: CGFloat
}
