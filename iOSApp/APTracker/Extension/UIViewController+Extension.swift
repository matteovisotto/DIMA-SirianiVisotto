//
//  UIViewController+Extension.swift
//  APTracker
//
//  Created by Matteo Visotto on 05/04/22.
//

import Foundation
import UIKit
import SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        hideKeyboardWhenTappedAround()
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
             let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
             tap.cancelsTouchesInView = false
             view.addGestureRecognizer(tap)
    }
    
         
         @objc func dismissKeyboard() {
             view.endEditing(true)
         }
}


