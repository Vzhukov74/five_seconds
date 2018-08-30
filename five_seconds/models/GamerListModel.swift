//
//  GamerListModel.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation
import UIKit

class GamerListModel {
    private let provider = CoreDataPlayerProvider()
    
    var players = [Player]()
    
    var updateUI: (() -> Void)?
    
    init() {
        provider.fetchPlayers { [weak self] (_players) in
            self?.players = _players
            self?.updateUI?()
        }
    }
    
    func addNewPlayer(with name: String, imageKey: String) {
        let player = Player(name: name, avatarKey: imageKey)
        provider.addNewPlayer(player: player)
        
        players.append(player)
        
        updateUI?()
    }
    
    func chosenPlayers() -> [Player] {
        return players.filter { $0.isChosen == true }
    }
    
    func removePlayer(at index: Int) {
        assert(index < players.count)
        provider.remove(player: players[index])
        players.remove(at: index)
        updateUI?()
    }
}
