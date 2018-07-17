//
//  GamerListModel.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation
import UIKit

class AvatarStore {
    class func avatar(for key: String) -> UIImage {
        return UIImage(named: "avatar") ?? UIImage()
    }
}

struct Player {
    let name: String
    let imageKey: String
}

class GamerListModel {
    var players = [Player]()
    
    var updateUI: (() -> Void)?
    
    func addNewPlayer(with name: String, imageKey: String) {
        players.append(Player(name: name, imageKey: imageKey))
        updateUI?()
    }
    
    func removePlayer(at index: Int) {
        assert(index < players.count)
        players.remove(at: index)
        updateUI?()
    }
}

