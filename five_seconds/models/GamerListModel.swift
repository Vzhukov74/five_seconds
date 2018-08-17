//
//  GamerListModel.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AvatarStore {
    static let avatarKeys = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    class func avatar(for key: String) -> UIImage {
        return UIImage(named: key) ?? UIImage()
    }
}

class CoreDataPlayerProvider {
    private var lastId: Int = 0
    
    func fetchPlayers(completion: @escaping ((_ players: [Player]) -> Void)) {
        DispatchQueue(label: "Core_Data_").async {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerCD")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DatabaseHelper.shared.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            do {
                try fetchedResultsController.performFetch()
                if let _players = fetchedResultsController.fetchedObjects as? [PlayerCD] {
                    var result = [Player]()
                    _players.forEach { (_player) in
                        result.append(Player(from: _player))
                    }
                    print("♦️ total players \(_players.count)")
                    
                    self.lastId = Int(_players.last?.id ?? 0)
                    print("♦️ lastId \(self.lastId)")
                    
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
            } catch {
                print("💥 error: \(error.localizedDescription)")
            }
        }
    }
    
    func addNewPlayer(player: Player) {
        DispatchQueue(label: "Core_Data_").async {
            let _player = PlayerCD(context: DatabaseHelper.shared.managedObjectContext)
            _player.name = player.name
            _player.avatarKey = player.avatarKey
            self.lastId += 1
            _player.id = Int64(self.lastId)
            DatabaseHelper.shared.saveContext()
        }
    }
}

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
        players.remove(at: index)
        updateUI?()
    }
}

