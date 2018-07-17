//
//  GameNavigation.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class GameNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let menu = MenuViewController.storyboardInstance {
            pushViewController(menu, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("💥 didReceiveMemoryWarning for GameNavigation")
    }
}

extension GameNavigation: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .navigation
}
