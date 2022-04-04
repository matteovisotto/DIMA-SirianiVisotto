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
    var expireAt: Date
}
