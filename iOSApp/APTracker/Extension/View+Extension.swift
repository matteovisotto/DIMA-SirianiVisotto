//
//  View+Extension.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import Foundation
import SwiftUI

extension View {
    func viewBackground(_ color: Color) -> some View {
        return ZStack {
            color
            self
        }
    }
}
