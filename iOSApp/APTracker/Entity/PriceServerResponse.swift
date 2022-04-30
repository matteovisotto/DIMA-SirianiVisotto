//
//  PriceServerResponse.swift
//  APTracker
//
//  Created by Matteo Visotto on 30/04/22.
//

import Foundation

class PriceServerResponse: Codable {
    var productId: String
    var prices: [Price]
}
