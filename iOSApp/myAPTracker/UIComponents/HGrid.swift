//
//  HGrid.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 03/05/22.
//

import SwiftUI

struct HGrid<Content: View>: View {
    
    let numberOfItems: Int
    let numberOfRows: Int
    let fakeNumber: Int
    let content: (_ contentIndex: Int) -> Content
    
    let elemPerRow: Int
    let maxIndex: Int
    
    @State private var offset = CGFloat.zero
    @State private var dragging = false
    @State var index = 0
        
    init(numberOfRows: Int, numberOfItems: Int, elemPerRow: Int = 1, @ViewBuilder contentBuilder: @escaping (_ contentIndex: Int) -> Content){
        self.numberOfRows = numberOfRows
        self.numberOfItems = numberOfItems
        self.content = contentBuilder
        self.fakeNumber = (numberOfItems%numberOfRows==0) ? numberOfItems : (numberOfItems + (numberOfRows - (numberOfItems % numberOfRows)))
        self.elemPerRow = elemPerRow
        let r = (Float(self.fakeNumber)/Float((numberOfRows*elemPerRow)) - 1).truncatingRemainder(dividingBy: 1)
        if(r == 0.0){
            self.maxIndex = self.fakeNumber/(numberOfRows*elemPerRow) - 1
        } else {
            self.maxIndex = self.fakeNumber/(numberOfRows*elemPerRow)
        }
    }
    
    var body: some View {
        
        
                GeometryReader{ geometry in
                    VStack(alignment: .leading, spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ForEach(0 ..< numberOfRows, id: \.self) {  row in
                            HStack(spacing: 0)  {
                                ForEach((0 ..< fakeNumber / numberOfRows).reversed(), id: \.self) { column in
                                    if(abs(determineCurrentCell(numberOfRows: self.numberOfRows, row: row, column: column) - (fakeNumber - 1)) > numberOfItems - 1) {
                                        VoidView().frame(maxWidth: .infinity, maxHeight: .infinity).clipped()
                                    } else {
                                        content(abs(determineCurrentCell(numberOfRows: self.numberOfRows, row: row, column: column) - (fakeNumber - 1)))
                                            .frame(width: (geometry.size.width / CGFloat(elemPerRow)-20), height: (geometry.size.height/CGFloat(numberOfRows))-20)
                                            .padding(.horizontal, 10).padding(.bottom, 10)
                                            .clipped()
                                    }
                                }
                            }
                        }
                    }.content.offset(x: self.offset(in: geometry), y: 0)
                        .frame(width: geometry.size.width, alignment: .leading)
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 10, coordinateSpace: .local).onChanged { value in
                                self.dragging = true
                                self.offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                            }
                            .onEnded { value in
                                let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                                let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                                self.index = self.clampedIndex(from: predictedIndex)
                                withAnimation(.easeOut) {
                                    self.dragging = false
                                }
                            }
                        )
                    }
                    .clipped()
                }
            }
    
        func offset(in geometry: GeometryProxy) -> CGFloat {
            if self.dragging {
                return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
            } else {
                return -CGFloat(self.index) * geometry.size.width
            }
        }

        func clampedIndex(from predictedIndex: Int) -> Int {
            let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
            guard newIndex >= 0 else { return 0 }
            guard newIndex <= self.maxIndex else { return self.maxIndex }
            return newIndex
        }
            
        
        func determineCurrentCell(numberOfRows: Int, row: Int, column : Int)-> Int {
            return ((((column + 1) * numberOfRows) - row) - 1)
            
        }


}

struct HGrid_Previews: PreviewProvider {
    static var previews: some View {
        HGrid(numberOfRows: 3, numberOfItems: 11) { contentIndex in
            Text("Cell \(contentIndex)")
        }
    }
}
