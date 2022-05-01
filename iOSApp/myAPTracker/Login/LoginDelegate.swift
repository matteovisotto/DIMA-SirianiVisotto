//
//  LoginDelegate.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation

protocol LoginDelegate {
    func didFinishLogin(withError error: String) -> Void
    func didFinishLogin(withSuccessCredential credential: LoginCredential) -> Void
}

extension LoginDelegate {
    func didFinishLogin(withError error: String) -> Void {}
}
