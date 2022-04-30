//
//  ProductComments.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import Foundation

class ProductComments: Codable {
    var productId: Int
    var numberOfComments: Int
    var comments: [Comment]
}

class Comment: Codable{
    var id: Int
    var productId: Int
    var comment: String
    var publishedAt: String
    var userId: Int
    var username: String
    var name: String
    var surname: String
}
