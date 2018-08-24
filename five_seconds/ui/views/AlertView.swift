//
//  AlertView.swift
//  5second
//
//  Created by Maximal Mac on 19.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class AlertView: UIView {

    private let okButton = UIButton()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        okButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(okButton)
        addSubview(titleLabel)
        
        let okButtonConstrains = [okButton.widthAnchor.constraint(equalToConstant: 100), okButton.heightAnchor.constraint(equalToConstant: 50), okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8), okButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)]
        
        NSLayoutConstraint.activate(okButtonConstrains)
        
        let titleLabelConstrains = [titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10), titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)]
        
        NSLayoutConstraint.activate(titleLabelConstrains)
        
        setupUI()
    }
    
    private func setupUI() {
        okButton.clipsToBounds = true
        okButton.cornerRadius = 25
        okButton.addTarget(self, action: #selector(self.okButtonAction), for: .touchUpInside)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        okButton.backgroundColor = Colors.mainButton
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
    }

    func show(on view: UIView, with message: String) {
        titleLabel.text = message
        
        let width = frame.width
        let height = frame.height
        
        let y = (view.bounds.height - height) / 2
        let x = (view.bounds.width - width) / 2
        
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        
        view.addSubview(self)
    }
    
    private func dismiss() {
        removeFromSuperview()
    }
    
    deinit {
        print("deinit - AlertView")
    }
}

@objc extension AlertView {
    private func okButtonAction() {
        dismiss()
    }
}

