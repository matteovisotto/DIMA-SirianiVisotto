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
    
    func toTopLeft(withPadding padding: CGFloat = 0) -> some View {
        return VStack{
            HStack{
               self
                Spacer()
            }
            Spacer()
        }.padding(.horizontal)
            .padding(.leading, padding)
            .padding(.top, padding)
    }
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
