//
//  AppSocialAuth.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation

class AppSocialAuth {
    
    enum Social{
        case google
        case facebook
    }
    
    private var social: AppSocialAuth.Social
    
    private var token: String
    
    private var tokenKey: String = ""
    private var urlString: String = ""
    
    init(token: String, social: AppSocialAuth.Social){
        self.social = social
        self.token = token
        switch social {
        case .facebook:
            urlString = AppConstant.facebookLoginURL
            tokenKey = "fbToken"
        case .google:
            urlString = AppConstant.googleLoginURL
            tokenKey = "gToken"
        }
    }
    
    func backendLogin(completionHandler: @escaping (_ error: Bool, _ message: String?, _ credential: LoginCredential?)->()){
        print(self.urlString)
        let url = URL(string: self.urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            tokenKey: token
        ]
        request.httpBody = parameters.percentEncoded()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(true, error.localizedDescription, nil)
                }
                return
            }
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completionHandler(true, "\(status)", nil)
                return
            }
            if let d = data {
                do {
                    let decoder = JSONDecoder()
                    let credential = try decoder.decode(LoginCredential.self, from: d)
                    DispatchQueue.main.async {
                        completionHandler(false, nil, credential)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(true, NSLocalizedString("jsonDecodeError", comment: "Unable to convert data"), nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(true, NSLocalizedString("dataTaskDataError", comment: "Unable to convert data"), nil)
                }
            }
        }

        task.resume()
    }
    
}
