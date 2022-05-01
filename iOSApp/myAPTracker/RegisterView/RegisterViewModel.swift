//
//  RegisterViewModel.swift
//  APTracker
//
//  Created by Matteo Visotto on 06/04/22.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordCnf: String = ""
    @Published var termsAndCondition: Bool = false
    
     var presentationMode: Binding<PresentationMode>? = nil
    
    init(){
    
    }
    
    func isFormInvalid() -> Bool {
        let invalidName: Bool = name.isEmpty || name == ""
        let invalidSurname: Bool = surname.isEmpty || surname == ""
        let invalidEmail: Bool = email.isEmpty || email == "" || !isValidEmail(email)
        let invalidPassword: Bool = password.isEmpty || password == "" || password != passwordCnf
        return invalidName || invalidSurname || invalidEmail || invalidPassword || !termsAndCondition
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func register() {
        let parameters: [String: Any] = [
            "name":self.name,
            "surname":self.surname,
            "email":self.email,
            "password": self.password
        ]
        let taskManager = TaskManager(urlString: AppConstant.registerURL, method: .POST, parameters: parameters)
        taskManager.execute { result, content, data in
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
                                    FeedbackAlert.present(text: NSLocalizedString("Success", comment: "Success"), icon: UIImage(systemName: "checkmark")!){
                                        self.resetForm()
                                        self.presentationMode?.wrappedValue.dismiss()
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
        
    }
    
    private func resetForm() {
        self.name = ""
        self.surname = ""
        self.password = ""
        self.passwordCnf = ""
        self.email = ""
        self.termsAndCondition = false
    }
    
    
}
