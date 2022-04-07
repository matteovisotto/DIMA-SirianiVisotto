//
//  AlertViewControllr.swift
//  APTracker
//
//  Created by Matteo Visotto on 05/04/22.
//

import Foundation

import UIKit

class AlertViewController: UIViewController {

    var alertView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.label.withAlphaComponent(0.25)
        setupLayout()
    }
    
    private func setupLayout() {
        alertView.backgroundColor = UIColor(named: "BackgroundColor")
        self.view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        alertView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        alertView.widthAnchor.constraint(equalToConstant: getWidth()).isActive = true
        alertView.layer.cornerRadius = 15
    }
    
    private func getWidth() -> CGFloat {
        var width: CGFloat = 300
        if(self.view.bounds.width <= 300){
            width = self.view.bounds.width - 40
        }
        return width
    }
    
}
