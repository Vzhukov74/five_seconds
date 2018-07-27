//
//  FinalResultViewController.swift
//  5second
//
//  Created by Maximal Mac on 27.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class FinalResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    deinit {
        print("deinit - FinalResultViewController")
    }
}

extension FinalResultViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .finalResult
}
