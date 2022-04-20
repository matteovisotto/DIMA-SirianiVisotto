//
//  TrackingObject.swift
//  APTracker
//
//  Created by Tia on 14/04/22.
//

import Foundation

struct TrackingObject: Codable {
    var id: Int
    var name: String
    var description: String
    var link: String
    var createdAt: String
    var lastUpdate: String
    var trackingSince: String
    var dropKey: String
    var dropValue: Double
    var images: [String]
    var prices: [Price]?
    var price: Double?
}

