//
//  SemicurcularSlider.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 10/05/22.
//

import Foundation
import SwiftUI

struct SemicircularSlider: View {
    
    @State var val: Double = 0
    
    var body: some View {
        VStack{
            ZStack{
                GeometryReader{ geom in
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(180))
                    Circle()
                        .trim(from: 0, to: val/2)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(180))
                    Circle()
                        .frame(width: 20)
                        .offset(x: (geom.size.width/2)-10, y: -geom.size.width/2)
                        
                    
                }//.frame(height: 200, alignment: .center)
                
                
            }
            Slider(value: $val)
        }
    }
    
}

struct SemicircularSlider_Previews: PreviewProvider {
    static var previews: some View {
        SemicircularSlider().padding()
    }
}
