//
//  WidgetProduct.swift
//  WidgetsExtension
//
//  Created by Matteo Visotto on 22/05/22.
//

import Foundation
import WidgetKit

struct WidgetProduct: Codable {
    var id: Int
    var name: String
    var shortName: String
    var highestPrice: Double
    var lowestPrice: Double
    var images: [String]
    var prices: [Price]?
    var price: Double?
    var lastUpdate: String?
    var createdAt: String?
}

struct WidgetModel: TimelineEntry {
    var date: Date
    var products: [WidgetProduct]
}
