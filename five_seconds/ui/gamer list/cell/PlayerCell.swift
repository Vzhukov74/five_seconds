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
    
    var removeAction: ((_ index: Int) -> Void)?
    var index: Int?
    var player: Player? {
        didSet {
            avatarImageView.image = AvatarStore.avatar(for: player!.imageKey)
            nameLabel.text = player!.name
        }
    }
}

@objc extension PlayerCell {
    private func removeButtonAction() {
        if let index = self.index {
            removeAction?(index)
        }
    }
}
