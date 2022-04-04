//
//  TaskManager.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation

class TaskManager {
    
    enum HTTPMethod: String {
        case GET = "GET"
        case POST = "POST"
    }
    
    private var urlString: String
    private var parameters: [String: Any]?
    private var method: TaskManager.HTTPMethod
    
    init(urlString: String, method: TaskManager.HTTPMethod = .GET, parameters: [String: Any]?){
        self.urlString = urlString
        self.method = method
        self.parameters = parameters
    }
    
    func execute(completionHandler: @escaping (_ result: Bool, _ content: String?, _ data: Data?) -> ()) -> Void {
        guard let url = URL(string: self.urlString) else {
            completionHandler(false, NSLocalizedString("Invalid URL", comment: "Invalid URL"), nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        if let param = parameters {
            if (self.method == .POST){
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
            request.httpBody = param.percentEncoded()
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(false, error.localizedDescription, nil)
                }
                return
            }
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completionHandler(false, "\(status)", nil)
                return
            }
            if let d = data {
                completionHandler(true, nil, d)
            } else {
                DispatchQueue.main.async {
                    completionHandler(false, NSLocalizedString("Unable to get data", comment: "Unable to get data"), nil)
                }
            }
        }

        task.resume()
    }
    
}
