//
//  LocalAuth.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation

class LocalAuth {
    var delegate: LoginDelegate? = nil
    
    func login(email: String, password: String) {
        let paramentes: [String: Any] = [
            "email": email,
            "password": password
        ]
        let taskManager = TaskManager(urlString: AppConstant.localLoginURL, method: .POST, parameters: paramentes)
        taskManager.execute { result, content, data in
            LoginCredential.parseAndDelegate(self.delegate, result: result, content: content, data: data)
        }
    }
    
}
