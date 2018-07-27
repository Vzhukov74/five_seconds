//
//  InterimResultViewController.swift
//  5second
//
//  Created by Maximal Mac on 27.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class InterimResultViewController: UIViewController {

    var model: GameResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        print("deinit - InterimResultViewController")
    }
}

extension InterimResultViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .interimResult
}
