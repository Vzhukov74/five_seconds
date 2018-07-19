//
//  MenuViewController.swift
//  5second
//
//  Created by Maximal Mac on 17.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var backgroundView: BackgroundView!
    
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.isHidden = true
            startButton.addTarget(self, action: #selector(self.startButtonAction), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startButton.isHidden = false
        backgroundView.setupAnimation()
    }
}

@objc extension MenuViewController {
    private func startButtonAction() {
        if let vc = GamerListViewController.storyboardInstance {
            startButton.isHidden = true
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .overCurrentContext
            vc.model = GamerListModel()
            vc.startGame = { [weak self] (vc) in
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            present(vc, animated: true, completion: nil)
        }
    }
}

extension MenuViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .menu
}
