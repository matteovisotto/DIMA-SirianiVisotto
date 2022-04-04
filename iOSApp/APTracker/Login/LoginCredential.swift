//
//  LoginCredential.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation

struct LoginCredential: Codable {
    var accessToken: String
    var refreshToken: String?
    var expireAt: String
    
    public static func parseAndDelegate(_ delegate: LoginDelegate?, result: Bool, content: String?, data: Data?){
        if result {
            do {
                let decoder = JSONDecoder()
                let credential = try decoder.decode(LoginCredential.self, from: data!)
                DispatchQueue.main.async {
                    delegate?.didFinishLogin(withSuccessCredential: credential)
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
                    delegate?.didFinishLogin(withError: errorStr)
                }
            }
        } else {
            DispatchQueue.main.async {
                delegate?.didFinishLogin(withError: content ?? NSLocalizedString("Unknown network error", comment: "Unknown network error"))
            }
        }
    }
    
}
