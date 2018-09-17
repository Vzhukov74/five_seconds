//
//  FinalResultViewController.swift
//  5second
//
//  Created by Maximal Mac on 27.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class FinalResultViewController: UIViewController {

    @IBOutlet weak var finishGameButton: UIButton! {
        didSet {
            finishGameButton.addTarget(self, action: #selector(self.finishGameButtonAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var playAgainButton: UIButton! {
        didSet {
            playAgainButton.addTarget(self, action: #selector(self.playAgainButtonAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var winTitlePlayerLabel: UILabel!
    @IBOutlet weak var winPlayerLabel: UILabel!
    @IBOutlet weak var resultView: ResultView!
    
    var model: GameResult!
    var completion: ((_ isNeedRestart: Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setWinners()
    }
    
    private func setWinners() {
        let winners = model.players.filter {$0.result == 10}
        
        var winnersList = ""
        winners.forEach({winnersList += $0.player.name + "\n"})
        
        winTitlePlayerLabel.text = winners.count > 1 ? "Winners is:" : "Winner is:"
        winPlayerLabel.text = winnersList
    }

    deinit {
        print("deinit - FinalResultViewController")
    }
}

extension FinalResultViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .finalResult
}

@objc extension FinalResultViewController {
    private func finishGameButtonAction() {
        completion?(false)
        dismiss(animated: true, completion: nil)
    }
    
    private func playAgainButtonAction() {
        completion?(true)
        dismiss(animated: true, completion: nil)
    }
}
