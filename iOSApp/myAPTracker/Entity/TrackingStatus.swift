//
//  TrackingStatus.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import Foundation

class TrackingStatus: Codable {
    var tracked: Bool
    var trackingSince: String?
    var dropKey: String?
    var dropValue: Double?
    var commentPolicy: String?
}
