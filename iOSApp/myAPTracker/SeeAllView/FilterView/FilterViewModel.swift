//
//  FilterViewModel.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 07/06/22.
//

import Foundation
import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var categories: [String] = []
    var bindingSelection: Binding<Array<String>>
    var isPresented: Binding<Bool>
    
    @Published var selected: [String] = []
    
    init(isPresented: Binding<Bool>, selectedCategories: Binding<Array<String>>){
        self.bindingSelection = selectedCategories
        self.isPresented = isPresented
        for x in selectedCategories.wrappedValue {
            selected.append(x)
        }
        loadCategories()
    }
    
    func save() -> Void {
        self.bindingSelection.wrappedValue = selected
    }
    
    private func loadCategories() -> Void {
        let taskManager = TaskManager(urlString: AppConstant.getCategories, method: .GET, parameters: nil)
        taskManager.execute { result, content, data in
            if(result){
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Categories.self, from: data!)
                    DispatchQueue.main.async {
                        self.categories = response.categories
                    }
                } catch {
                }
            }
        }
    }
    
}
