//
//  DropPriceProduct.swift
//  myAPTracker
//
//  Created by Tia on 18/05/22.
//

import Foundation
import UIKit

struct Product: Codable {
    var id: Int
    var name: String
    var shortName: String
    var description: String
    var highestPrice: Double
    var lowestPrice: Double
    var images: [String]
    var price: Double?
    var lastUpdate: String?
    var createdAt: String?
    var priceDrop: Float
    var priceDropPercentage: Float
    var category: String
}

