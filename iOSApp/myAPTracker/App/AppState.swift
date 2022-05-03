//
//  AppState.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    
    public static let shared: AppState = AppState()
    
    @Published var isUserLoggedIn: Bool = false
    var userCredential: LoginCredential? = nil
    @Published var userIdentity: UserIdentity? = nil
    @Published var areNotificationsEnabled = false
    
    init() {
        reloadState()
    }
    
    func reloadState() {
        let credential = KeychainHelper.standard.read(service: AppConstant.keychainCredentialKey, account: AppConstant.backendDomain, type: LoginCredential.self)
        self.userIdentity = PreferenceManager.shared.getUserIdentity()
         if let credential = credential {
             self.userCredential = credential
             if(isTokenValid(credential)){
                 self.isUserLoggedIn = true
             } else {
                 self.refreshToken(credential)
             }
         }
    }
    
    func logout() {
        guard let credential = self.userCredential else {return}
            if let rToken = credential.refreshToken {
            let parameters: [String: Any] = [
                "token": credential.accessToken,
                "refreshToken": rToken,
                "deviceId": UIDevice.current.identifierForVendor?.uuidString ?? ""
            ]
            let taskManager = TaskManager(urlString: AppConstant.logoutURL, method: .POST, parameters: parameters)
            taskManager.execute { result, content, data in
                if result {
                    var message = NSLocalizedString("Unable to perform remote logout", comment: "Unable to perform remote logout")
                    do {
                        let resultObj = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                        if let r =  resultObj{
                            if let d = r["exception"] as? String {
                                message = d
                            }
                            if let _ = r["success"] as? String {
                                DispatchQueue.main.async {
                                    self.localLogout()
                                }
                                return
                            }
                        }
                    } catch {}
                    DispatchQueue.main.async {
                        self.riseError(title: NSLocalizedString("Error", comment: "Error"), message: message)
                        self.localLogout()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.riseError(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Unable to perform remote logout", comment: "Unable to perform remote logout"))
                        self.localLogout()
                    }
                    
                }
            }
        } else {
            self.localLogout()
        }
    }
    
    private func localLogout(){
        KeychainHelper.standard.delete(service: AppConstant.keychainCredentialKey, account: AppConstant.backendDomain)
        PreferenceManager.shared.removeUserIdentity()
        self.isUserLoggedIn = false
    }
    
    private func isTokenValid(_ credential: LoginCredential) -> Bool {
        let formatter = DateFormatter()
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: credential.expireAt)
        if let date = date {
            let oneHAgo = Calendar.current.date(byAdding: .hour, value:  2, to: Date())!
            return date > oneHAgo
        }
        return false
    }
    
    func refreshToken(_ credential: LoginCredential) {
        guard let rToken = credential.refreshToken else {
            self.didFinishLogin(withError: NSLocalizedString("Unable to find refresh token", comment: "Unable to find refresh token"))
            return
        }
        let taskManager = TaskManager(urlString: AppConstant.refreshTokenURL, method: .POST, parameters: ["refreshToken":rToken])
        taskManager.execute { result, content, data in
            LoginCredential.parseAndDelegate(self, result: result, content: content, data: data)
        }
    }
    
    func riseError(title: String, message: String) -> Void {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let alert = ErrorAlertController()
            alert.setContent(title: title, message: message)
            alert.modalPresentationStyle = .overFullScreen
            topController.present(alert, animated: true, completion: nil)
            
            
        }
    }
    
}

extension AppState: LoginDelegate {
    func didFinishLogin(withSuccessCredential credential: LoginCredential) {
        var newC = credential
        newC.refreshToken = self.userCredential?.refreshToken
        KeychainHelper.standard.save(newC, service: AppConstant.keychainCredentialKey, account: AppConstant.backendDomain)
        self.reloadState()
    }
    
    func didFinishLogin(withError error: String) {
        self.riseError(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("We cannot refresh your key, please login again", comment: "We cannot refresh your key, please login again"))
        self.localLogout()
    }
    
}
