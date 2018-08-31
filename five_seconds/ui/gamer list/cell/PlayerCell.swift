//
//  PlayerCell.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton! {
        didSet {
            removeButton.addTarget(self, action: #selector(self.removeButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var isChosenImageView: UIImageView! {
        didSet {
            isChosenImageView.tintColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 0.9)
        }
    }
    
    var removeAction: ((_ index: Int) -> Void)?
    var index: Int?
    var player: Player? {
        didSet {
            update()
        }
    }
    
    func toggle() {
        player?.toggle()
        update()
    }
    
    private func update() {
        guard let _player = self.player else { return }
        avatarImageView.tintColor = UIColor.white
        avatarImageView.image = AvatarStore.avatar(for: _player.avatarKey)
        nameLabel.text = _player.name
        isChosenImageView.tintColor = _player.isChosen ? UIColor.white : UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 0.9)
    }
}

@objc extension PlayerCell {
    private func removeButtonAction() {
        if let index = self.index {
            removeAction?(index)
        }
    }
}
