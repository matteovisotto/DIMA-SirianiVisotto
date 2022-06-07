//
//  File.swift
//  myAPTracker
//
//  Created by Matteo Visotto on 19/05/22.
//

import Foundation

class SeeAllViewModel: ObservableObject {
    private var sem: Bool = false
    @Published var viewTitle: String = ""
    @Published var products: [Product] = [] {
        didSet{
            if categoryFilters.count > 0 {
                self.applyFilter()
            }
        }
    }
    @Published var isLoading: Bool = false
    @Published var showFilterView: Bool = false
    private var apiUrl: String
    @Published var pageIndex: Int = 0
    
    @Published var categoryFilters: [String] = [] {
        didSet {
            self.applyFilter()
        }
    }
    @Published var filteredProducts: [Product] = []
    
    init(apiUrl: String, viewTitle: String) {
        self.viewTitle = viewTitle
        self.apiUrl = apiUrl
    }
    
    func applyFilter() {
        self.filteredProducts.removeAll()
        self.filteredProducts = self.products.filter { obj in
            self.categoryFilters.contains(obj.category)
        }
    }
    
    func loadMore() -> Void {
        if sem {
            return
        }
        sem = true
        self.isLoading = true
        pageIndex = self.pageIndex
        let task = TaskManager(urlString: self.apiUrl.prefix(self.apiUrl.count - 1) + "\(self.pageIndex)", method: .GET, parameters: nil)
        task.execute { result, content, data in
            DispatchQueue.main.async {
                self.sem = false
                self.isLoading = false
            }
            if result {
                do {
                    let decoder = JSONDecoder()
                    let identity = try decoder.decode([Product].self, from: data!)
                    DispatchQueue.main.async {
                        self.products.append(contentsOf: identity)
                        self.pageIndex = self.pageIndex + 1
                    }
                } catch {
                    var errorStr = NSLocalizedString("Unable to parse the received content", comment: "Unable to convert data")
                    do {
                        let error = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                        if let e = error {
                            if let d = e["exception"] as? String {
                                errorStr = d
                            }
                        }
                    } catch {}
                    DispatchQueue.main.async {
                        AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: errorStr)
                    }
                    
                }
            } else {
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unknown error", comment: "Unknown error"))
                }
                
            }
        }
    }
    
}
