//
//  Product.swift
//  APTracker
//
//  Created by Matteo Visotto on 20/04/22.
//

import Foundation

struct Product: Codable {
    var id: Int
    var name: String
    var description: String
    var link: String
    var images: [String]
    var prices: [Price]?
    var price: Double?
}
