//
//  UserProfileViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import Foundation
import SwiftUI

class UserProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var username: String = ""
    @Published var oldPassword: String = ""
    @Published var password: String = ""
    @Published var passwordCnf: String = ""
    
    init(){
        onAppear()
    }
    
    func onAppear() -> Void{
        name = AppState.shared.userIdentity?.name ?? ""
        surname = AppState.shared.userIdentity?.surname ?? ""
        username = AppState.shared.userIdentity?.username ?? ""
    }
    
    func changePassword() -> Void {
        if(password != passwordCnf){
            AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("New password confirmation doesn't match", comment: "New password confirmation doesn't match"))
        }
        let params:[String: Any] = [
            "oldPassword":self.oldPassword,
            "newPassword":self.password,
            "newPasswordCnf":self.passwordCnf
        ]
        let taskManager = TaskManager(urlString: AppConstant.changeUserPassword, method: .POST, parameters: params)
        taskManager.executeWithAccessToken { result, content, data in
            self.parseResult(result, content, data)
        }
    }
    
    func updateProfile() -> Void {
        let params:[String: Any] = [
            "name":self.name,
            "surname":self.surname,
            "username":self.username
        ]
        let taskManager = TaskManager(urlString: AppConstant.updateUserProfile, method: .POST, parameters: params)
        taskManager.executeWithAccessToken { result, content, data in
            self.parseResult(result, content, data)
        }
    }
    
    private func parseResult(_ result: Bool, _ content: String?, _ data: Data?) {
        if(result){
                var message = NSLocalizedString("Unable to parse the received content", comment: "Unable to convert data")
                do {
                    let c = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    if let e = c {
                        if let d = e["exception"] as? String {
                            message = d
                        }
                        if let _ = e["success"] as? String {
                            DispatchQueue.main.async{
                                if let currentIdentity = PreferenceManager.shared.getUserIdentity() {
                                    PreferenceManager.shared.setUserIdentity(UserIdentity(id: currentIdentity.id, name: self.name, surname: self.surname, email: currentIdentity.email, username: self.username, createdAt: currentIdentity.createdAt))
                                    AppState.shared.reloadState()
                                }
                                FeedbackAlert.present(text: NSLocalizedString("Success", comment: "Success"), icon: UIImage(systemName: "checkmark")!){
                                }
                            }
                            return
                        }
                    }
                } catch {}
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: message)
                }
            } else {
                DispatchQueue.main.async {
                    AppState.shared.riseError(title: NSLocalizedString("Error", comment: "Error"), message: content ?? NSLocalizedString("Unexpected error occurred", comment: "Unexpected error occurred"))
                }
            }
    }
    
    func validatePassword() -> Bool {
        return password != "" && passwordCnf != "" && oldPassword != ""
    }
    
    func validateUserData() -> Bool {
        return name != "" && surname != "" &&  username != ""
    }
}
