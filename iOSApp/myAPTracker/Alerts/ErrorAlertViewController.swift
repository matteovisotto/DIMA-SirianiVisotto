//
//  ErrorAlertViewController.swift
//  APTracker
//
//  Created by Matteo Visotto on 05/04/22.
//

import Foundation
import UIKit

class ErrorAlertController: AlertViewController {
    
    private let titleLabel = UILabel()
    private let messageLable = UILabel()
    private let dismissButton = UIButton()
    
    private let iconView = UIView()
    private let circleView = UIView()
    private let errorIcon = UIImageView(image: UIImage(systemName: "multiply"))

    private var alertTitle: String = ""
    private var alertMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        alertView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iconView.backgroundColor = UIColor(named: "BackgroundColor")
        iconView.layer.cornerRadius = 70/2
        iconView.bottomAnchor.constraint(equalTo: alertView.topAnchor, constant: 70/2).isActive = true
        iconView.leftAnchor.constraint(equalTo: alertView.leftAnchor,constant: 15).isActive = true
        
        iconView.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        circleView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        circleView.backgroundColor = .clear
        circleView.layer.cornerRadius = 55/2
        circleView.layer.borderColor = UIColor.systemRed.cgColor
        circleView.layer.borderWidth = 3
        
        iconView.addSubview(errorIcon)
        errorIcon.translatesAutoresizingMaskIntoConstraints = false
        errorIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        errorIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        errorIcon.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        errorIcon.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        errorIcon.tintColor = UIColor.systemRed
        
        
        alertView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(named: "PrimaryLabel")
        titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 25).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -15).isActive = true
       
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        titleLabel.text = self.alertTitle
        
        alertView.addSubview(messageLable)
        messageLable.translatesAutoresizingMaskIntoConstraints = false
        messageLable.textColor = UIColor(named: "PrimaryLabel")
        messageLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        messageLable.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 15).isActive = true
        messageLable.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -15).isActive = true
        messageLable.numberOfLines = .zero
        messageLable.text = self.alertMessage
        
        let divider = UIView()
        divider.backgroundColor = UIColor(named: "LabelColor")
        alertView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 5).isActive = true
        divider.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -5).isActive = true
        divider.topAnchor.constraint(equalTo: messageLable.bottomAnchor, constant: 10).isActive = true
        
        alertView.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: alertView.leftAnchor).isActive = true
        dismissButton.rightAnchor.constraint(equalTo: alertView.rightAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dismissButton.backgroundColor = .clear
        dismissButton.setTitle(NSLocalizedString("Dismiss", comment: "Dismiss"), for: .normal)
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        dismissButton.setTitleColor(UIColor(named: "PrimaryLabel"), for: .normal)
        
    }
    
    public func setContent(title: String?, message: String) {
        self.alertTitle = title ?? ""
        self.alertMessage = message
    }
    
    @objc private func didTapDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
