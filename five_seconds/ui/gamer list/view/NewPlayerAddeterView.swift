//
//  NewPlayerAddeterView.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class NewPlayerAddeterView: UIView {

    private let avatarImageView = UIImageView()
    private let nameInput = UITextField()
    private let cancelButton = UIButton()
    private let okButton = UIButton()
    private let tableView = UITableView()
    
    private var name = ""
    private var avatarKey = ""
    
    var addPlayerAction: ((_ plyer: Player) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        avatarImageView.isUserInteractionEnabled = true
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addAvatarAction)))
        
        okButton.addTarget(self, action: #selector(self.okButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.cancelButtonAction), for: .touchUpInside)
        
        addSubview(avatarImageView)
        addSubview(nameInput)
        addSubview(cancelButton)
        addSubview(okButton)
        addSubview(tableView)
        
        let avatarImageViewConstrains = [avatarImageView.widthAnchor.constraint(equalToConstant: 40), avatarImageView.heightAnchor.constraint(equalToConstant: 40), avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8), avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)]
        
        NSLayoutConstraint.activate(avatarImageViewConstrains)
        
        let nameInputConstrains = [nameInput.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8), nameInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8), nameInput.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 0)]
        
        NSLayoutConstraint.activate(nameInputConstrains)
        
        let buttonWidth = (UIScreen.main.bounds.width - CGFloat(20 + 20 + 8 + 8 + 8)) / 2
        
        let cancelButtonConstrains = [cancelButton.heightAnchor.constraint(equalToConstant: 40), cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth), cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8), cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)]
        
        NSLayoutConstraint.activate(cancelButtonConstrains)
        
        let okButtonConstrains = [okButton.heightAnchor.constraint(equalToConstant: 40), okButton.widthAnchor.constraint(equalToConstant: buttonWidth), okButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8), okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)]
        
        NSLayoutConstraint.activate(okButtonConstrains)
        
        let tableViewConstrains = [tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0), tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0), tableView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8), tableView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: 8)]
        
        NSLayoutConstraint.activate(tableViewConstrains)
        
        avatarImageView.image = AvatarStore.avatar(for: "")
    }
    
    deinit {
        print("deinit - NewPlayerAddeterView")
    }
}

@objc extension NewPlayerAddeterView {
    private func cancelButtonAction() {
        removeFromSuperview()
    }
    
    private func okButtonAction() {
        let _name = nameInput.text ?? ""
        let _avatarKey = "1"
        
        if !_name.isEmpty, !_avatarKey.isEmpty {
            addPlayerAction?(Player(name: _name, imageKey: _avatarKey))
            removeFromSuperview()
        }
    }
    
    private func addAvatarAction() {
        
    }
}
