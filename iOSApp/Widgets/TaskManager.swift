//
//  TaskManager.swift
//  WidgetsExtension
//
//  Created by Matteo Visotto on 22/05/22.
//

import Foundation


class TaskManager {
    public static func execute(urlString: String, completionHandler: @escaping (_ result: Bool, _ content: String?, _ data: Data?) -> ()) -> Void {
        guard let url = URL(string: urlString) else {
            completionHandler(false, NSLocalizedString("Invalid URL", comment: "Invalid URL"), nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
