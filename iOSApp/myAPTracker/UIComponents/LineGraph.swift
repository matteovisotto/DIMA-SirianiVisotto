//
//  LineGraph.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 19/05/22.
//

import SwiftUI

struct LineGraph: View {
    var data: [CGFloat]
    
    var lineWidth: CGFloat
    var lineColors: [Color]
    var fillGradientColors: [Color]
    
    @State var currentPlot = ""
    @State var currentOffset: CGSize = .zero
    @State var showPlot: Bool = false
    @State var translation: CGFloat = 0
    @State var labelOffset: CGFloat = 15
    
    
    init(data: [Double], lineWidth: CGFloat = 1.5, lineColors: [Color] = [Color.blue, Color.black], fillGradientColors: [Color] = [Color.blue.opacity(0.3),Color.blue.opacity(0.2),Color.blue.opacity(0.1)]){
        self.data = data.map{CGFloat($0)}
        self.lineColors = lineColors
        self.lineWidth = lineWidth
        self.fillGradientColors = fillGradientColors
    }
    
    var body: some View {
        GeometryReader{ proxy in
            
                let width = (proxy.size.width) / CGFloat(data.count-1)
                let height = proxy.size.height*2/3
                let maxPoint = (data.max() ?? 0)
                let minPoint = (data.min() ?? 0)
                let points = data.enumerated().compactMap{ item -> CGPoint in
                    var progress = item.element / maxPoint
                    if(progress != 1){
                        if(item.element != 0 && item.element == minPoint){
                            progress = 0.2
                        } else {
                            progress = ((item.element - minPoint) / (maxPoint - minPoint)) + 0.2
                        }
                    } else {
                        progress = progress + 0.2
                    }
                    let pathHeight = (progress * (height))
                    let pathWidth = width * CGFloat(item.offset)
                    return CGPoint(x: pathWidth, y: -pathHeight+height)
                }
            
            VStack{
                Spacer().frame(width: proxy.size.width,height: proxy.size.height/3, alignment: .leading)
                ZStack{
                    
                    Path{ path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLines(points)
                        
                    }.strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        .fill(LinearGradient(colors: lineColors, startPoint: .leading, endPoint: .trailing))
                    LinearGradient(colors: fillGradientColors + getRepeating()
                    , startPoint: .top, endPoint: .bottom)
                        .clipShape(
                            Path{ path in
                                path.move(to: CGPoint(x: 0, y: 0))
                                path.addLines(points)
                                path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                                path.addLine(to: CGPoint(x: 0, y: height))
                            }
                        )
                }
                .frame(height: proxy.size.height*2/3)
                .overlay(
                    VStack(spacing: 0){
                        Text(currentPlot)
                            .font(.caption.bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(Color("Primary"))
                            .cornerRadius(20)
                            .offset(x: translation < 10 ? 30 : 0)
                            .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                        Rectangle()
                            .fill (Color ( "Primary") )
                            .frame (width: 1, height: labelOffset)
                            .padding(.top, 10)
                        Circle()
                            .fill (Color ( "Primary") )
                            .frame (width: 22, height: 22)
                            .overlay(
                                Circle()
                                    .fill(.white)
                                    .frame (width: 10, height: 10)
                            )
                        Rectangle()
                            .fill(Color("Primary"))
                                .frame (width: 1, height: labelOffset)
                            
                    }
                        .frame(width: 80, height: 170)
                        .opacity(showPlot ? 1 : 0)
                        .offset(y: 70)
                        .offset(currentOffset),
                    alignment: .bottomLeading
                )
                .contentShape(Rectangle())
                .gesture(DragGesture().onChanged({ value in
                    withAnimation {showPlot = true}
                    let translation = value.location.x
                    
                    let index = max(min(Int((translation / width).rounded() + 1), data.count-1),0)
                    currentPlot = "\(data[index]) €"
                    
                    currentOffset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                    self.translation = translation
                }).onEnded({ value in
                    withAnimation {showPlot = false}
                }))
            }
        }
        .padding(.vertical, 10)
    }
    

    func getRepeating() -> Array<Color> {
        return Array(repeating: fillGradientColors.last ?? Color.clear, count: 4) + Array(repeating: Color.clear, count: 2)
    }
}


struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        LineGraph(data: [12.99, 25.99, 13.99, 11.0, 8.89, 15.99, 20.33, 20.33, 20.33, 30, 30, 30, 30, 12.99, 25.99, 13.99, 11.0, 8.89, 8.79, 8.89, 15.99, 20.33, 20.33, 20.33, 30, 30, 29.9,30, 30, 30]).frame(height: 140).padding()
    }
}
