//
//  ErrorAlertViewController.swift
//  APTracker
//
//  Created by Matteo Visotto on 05/04/22.
//

import Foundation
import UIKit

class EditCommentAlertViewController: AlertViewController {
    
    private let titleLabel = UILabel()
    private let dismissButton = UIButton()
    private let saveButton = UIButton()
    private let editText = UITextView()

    private var alertTitle: String = NSLocalizedString("Edit comment", comment: "Edit comment")
    private var saveAction: (_ comment: String) -> () = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        alertView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(named: "PrimaryLabel")
        titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 25).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -15).isActive = true
       
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        titleLabel.text = self.alertTitle
        
        alertView.addSubview(editText)
        editText.translatesAutoresizingMaskIntoConstraints = false
        editText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        editText.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 15).isActive = true
        editText.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -15).isActive = true
        editText.heightAnchor.constraint(equalToConstant: 200).isActive = true
        editText.textColor = UIColor(named: "PrimaryLabel")
        editText.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.2)
        editText.font = .systemFont(ofSize: 16)
        
        
        let divider = UIView()
        divider.backgroundColor = UIColor(named: "LabelColor")
        alertView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 5).isActive = true
        divider.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -5).isActive = true
        divider.topAnchor.constraint(equalTo: editText.bottomAnchor, constant: 10).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        alertView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: alertView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: alertView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.addArrangedSubview(dismissButton)
        stackView.addArrangedSubview(saveButton)
        dismissButton.backgroundColor = .clear
        dismissButton.setTitle(NSLocalizedString("Dismiss", comment: "Dismiss"), for: .normal)
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        dismissButton.setTitleColor(UIColor(named: "PrimaryLabel"), for: .normal)
        saveButton.backgroundColor = .clear
        saveButton.setTitle(NSLocalizedString("Save", comment: "Save"), for: .normal)
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        saveButton.setTitleColor(UIColor(named: "PrimaryLabel"), for: .normal)
        
    }
    
    public func setContent(comment: String, onSave: @escaping (_ comment: String) -> ()) {
        self.editText.text = comment
        self.saveAction = onSave
    }
    
    @objc private func didTapDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapSave() {
        self.dismiss(animated: true, completion: nil)
        self.saveAction(self.editText.text)
    }
    
    public static func present(comment: String, onSave: @escaping (_ comment: String) -> () = {_ in}) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let alert = EditCommentAlertViewController()
            alert.setContent(comment: comment, onSave: onSave)
            alert.modalPresentationStyle = .overFullScreen
            topController.present(alert, animated: true, completion: nil)
        }
    }
}

