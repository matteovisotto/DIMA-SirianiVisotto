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
        
    init(numberOfRows: Int, numberOfItems: Int, @ViewBuilder contentBuilder: @escaping (_ contentIndex: Int) -> Content){
            self.numberOfRows = numberOfRows
            self.numberOfItems = numberOfItems
            self.content = contentBuilder
            self.fakeNumber = numberOfItems + (numberOfRows - (numberOfItems % numberOfRows))
    }
    
    var body: some View {
        
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    ForEach(0 ..< numberOfRows, id: \.self) {  row in
                        HStack  {
                            ForEach((0 ..< fakeNumber / numberOfRows).reversed(), id: \.self) { column in
                                if(abs(determineCurrentCell(numberOfRows: self.numberOfRows, row: row, column: column) - (fakeNumber - 1)) > numberOfItems - 1) {
                                    VoidView()
                                } else {
                                    content(abs(determineCurrentCell(numberOfRows: self.numberOfRows, row: row, column: column) - (fakeNumber - 1)))
                                }
                            }
                        }
                    }
                }
            }
        
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
