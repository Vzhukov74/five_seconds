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
        
        addSubview(okButton)
        
        let okButtonConstrains = [okButton.widthAnchor.constraint(equalToConstant: 100), okButton.heightAnchor.constraint(equalToConstant: 50), okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8), okButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)]
        
        NSLayoutConstraint.activate(okButtonConstrains)
        
        setupUI()
    }
    
    private func setupUI() {
        okButton.clipsToBounds = true
        okButton.cornerRadius = 25
        okButton.addTarget(self, action: #selector(self.okButtonAction), for: .touchUpInside)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        okButton.backgroundColor = Colors.mainButton
    }

    func show(on view: UIView) {
        self.center = view.center
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

