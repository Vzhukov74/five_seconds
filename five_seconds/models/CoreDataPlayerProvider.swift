//
//  CoreDataPlayerProvider.swift
//  5second
//
//  Created by Maximal Mac on 29.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation
import CoreData

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
    
    func remove(player: Player) {
        let id = player.id
        DispatchQueue(label: "Core_Data_").async {
            let fetchRequest: NSFetchRequest<PlayerCD> = PlayerCD.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id==\(String(id))")
            
            do {
                let objects = try DatabaseHelper.shared.managedObjectContext.fetch(fetchRequest)
                for object in objects {
                    DatabaseHelper.shared.managedObjectContext.delete(object as NSManagedObject)
                }
                DatabaseHelper.shared.saveContext()
            } catch {
                print("core data error = \(error.localizedDescription)")
            }
        }
    }
}
