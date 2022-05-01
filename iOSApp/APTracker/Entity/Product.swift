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
    var lastUpdate: String?
    var createdAt: String?
    
    public static func fromTracked(_ p: TrackedProduct) -> Product {
        return Product(id: p.id, name: p.name, description: p.description, link: p.link, images: p.images, prices: p.prices, price: p.price)
    }
}
