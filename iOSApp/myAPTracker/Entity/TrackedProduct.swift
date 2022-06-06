//
//  TrackingObject.swift
//  APTracker
//
//  Created by Tia on 14/04/22.
//

import Foundation
import UIKit

struct TrackedProduct: Codable {
    var id: Int
    var name: String
    var shortName: String
    var description: String
    var link: String
    var highestPrice: Double
    var lowestPrice: Double
    var createdAt: String
    var lastUpdate: String
    var trackingSince: String
    var dropKey: String
    var dropValue: Double
    var images: [String]
    var prices: [Price]?
    var price: Double?
    var category: String
}

