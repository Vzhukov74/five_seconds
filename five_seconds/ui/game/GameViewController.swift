//
//  GameViewController.swift
//  5second
//
//  Created by Maximal Mac on 19.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var model: GameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension GameViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .game
}
