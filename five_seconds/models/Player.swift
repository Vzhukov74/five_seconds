//
//  Player.swift
//  5second
//
//  Created by Maximal Mac on 01.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation

class Player {
    let name: String
    let avatarKey: String
    let id: Int
    var isChosen: Bool
    
    init(from player: PlayerCD) {
        name = player.name ?? ""
        avatarKey = player.avatarKey ?? ""
        id = Int(player.id)
        isChosen = false
    }
    
    init(name: String, avatarKey: String) {
        self.name = name
        self.avatarKey = avatarKey
        id = 0
        isChosen = false
    }
    
    func toggle() {
        isChosen = !isChosen
    }
}
