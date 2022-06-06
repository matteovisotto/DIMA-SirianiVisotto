//
//  Product.swift
//  APTracker
//
//  Created by Matteo Visotto on 20/04/22.
//

import Foundation
import UIKit

struct Product: Codable {
    var id: Int
    var name: String
    var shortName: String
    var description: String
    var link: String
    var highestPrice: Double
    var lowestPrice: Double
    var images: [String]
    var prices: [Price]?
    var price: Double?
    var lastUpdate: String?
    var createdAt: String?
    var category: String
    
    public static func fromTracked(_ p: TrackedProduct) -> Product {
        return Product(id: p.id, name: p.name, shortName: p.shortName, description: p.description, link: p.link, highestPrice: p.highestPrice, lowestPrice: p.lowestPrice, images: p.images, prices: p.prices, price: p.price, category: p.category)
    }
    
    public static func fromPriceDrop(_ p: DropPriceProduct) -> Product {
        return Product(id: p.id, name: p.name, shortName: p.shortName, description: p.description, link: p.link ?? "", highestPrice: p.highestPrice, lowestPrice: p.lowestPrice, images: p.images, prices: p.prices, price: p.price, category: p.category)
    }
}
