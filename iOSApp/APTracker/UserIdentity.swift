//
//  User.swift
//  APTracker
//
//  Created by Matteo Visotto on 07/04/22.
//

import Foundation

struct UserIdentity: Codable {
    var id: Int
    var name: String
    var surname: String
    var email: String
    var username: String
    var createdAt: String
}
