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
    private var avatarChoicerView: AvatarChoicerView?
    
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
        
        let avatarImageViewConstrains = [avatarImageView.widthAnchor.constraint(equalToConstant: 50), avatarImageView.heightAnchor.constraint(equalToConstant: 50), avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8), avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)]
        
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
        
        setupElements()
    }
    
    private func setupElements() {
        nameInput.placeholder = "Enter the name"
        nameInput.font = UIFont(name: "Helvetica Neue", size: 14)!
        nameInput.tintColor = UIColor.white
        nameInput.textColor = UIColor.white
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = UIColor.white
        
        okButton.setTitle("Add", for: .normal)
        okButton.tintColor = UIColor.white
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        avatarImageView.cornerRadius = 25
        avatarImageView.clipsToBounds = true
        
        avatarImageView.image = AvatarStore.avatar(for: "add_photo")
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addAvatarAction)))
    }
    
    private func removeSelf() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
     
    deinit {
        print("deinit - NewPlayerAddeterView")
    }
}

@objc extension NewPlayerAddeterView {
    private func cancelButtonAction() {
        removeSelf()
    }
    
    private func okButtonAction() {
        let _name = nameInput.text ?? ""
        let _avatarKey = "1"
        
        if !_name.isEmpty, !_avatarKey.isEmpty {
            addPlayerAction?(Player(name: _name, imageKey: _avatarKey))
            removeSelf()
        }
    }
    
    private func addAvatarAction() {
        let width = self.bounds.width
        
        let model = AvatarChoicerModel()
        
        let elementsInRow: CGFloat = CGFloat(Int(width / 50))
        let rows = CGFloat(Int((CGFloat(model.keys.count) / CGFloat(elementsInRow)) + 0.9))
        let height: CGFloat = (rows * 54) + 4
        
        avatarChoicerView = AvatarChoicerView(frame: CGRect(x: 0, y: 70, width: width, height: 0))
        avatarChoicerView!.model = model
        avatarChoicerView!.cornerRadius = 25
        avatarChoicerView!.clipsToBounds = true
        avatarChoicerView!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        avatarChoicerView!.didChosenAvatar = { [weak self] in
            print($0)
        }
        
        addSubview(avatarChoicerView!)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
            self.avatarChoicerView!.frame = CGRect(x: 0, y: 50, width: width, height: height)
        }) { (_) in

        }
    }
}

struct AvatarChoicerModel {
    let keys = ["test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test",]
}

class AvatarChoicerView: UIView {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var model: AvatarChoicerModel!
    var didChosenAvatar: ((_ key: String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        let collectionViewConstrains = [collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0), collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0), collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0), collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)]
        
        NSLayoutConstraint.activate(collectionViewConstrains)
        
        collectionView.register(AvatarChoicerCell.self, forCellWithReuseIdentifier: "AvatarChoicerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let viewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            viewLayout.itemSize = CGSize(width: 50, height: 50)
            viewLayout.minimumLineSpacing = 4
            viewLayout.minimumInteritemSpacing = 4
            viewLayout.sectionInset.top = 4
            viewLayout.sectionInset.bottom = 4
            viewLayout.sectionInset.left = 4
            viewLayout.sectionInset.right = 4
        }
        
        collectionView.reloadData()
    }
    
    private func removeSelf() {
        let width = self.bounds.width
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.frame = CGRect(x: 0, y: 50, width: width, height: 0)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}

extension AvatarChoicerView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarChoicerCell", for: indexPath) as? AvatarChoicerCell {
            let key = model.keys[indexPath.row]
            cell.avatarKey = key
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        didChosenAvatar?(model.keys[indexPath.row])
        removeSelf()
    }
}

class AvatarChoicerCell: UICollectionViewCell {
    private let avatar = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatar)
        
        avatar.cornerRadius = 25
        avatar.clipsToBounds = true
        contentView.backgroundColor = UIColor.clear
        
        let avatarConstrains = [avatar.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0), avatar.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0), avatar.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0), avatar.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)]
        
        NSLayoutConstraint.activate(avatarConstrains)
    }
    
    var avatarKey: String? {
        didSet {
           avatar.image = AvatarStore.avatar(for: avatarKey!)
        }
    }
}
