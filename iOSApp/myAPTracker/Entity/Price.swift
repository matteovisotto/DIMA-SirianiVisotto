//
//  Price.swift
//  APTracker
//
//  Created by Matteo Visotto on 14/04/22.
//b

import Foundation

class Price: Codable {
    var updatedAt: String
    var price: Double
    
    init(updatedAt: String, price: Double){
        self.updatedAt = updatedAt
        self.price = price
    }
    
}
