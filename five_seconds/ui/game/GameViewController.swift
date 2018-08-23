//
//  GameViewController.swift
//  5second
//
//  Created by Maximal Mac on 19.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var questionView: GameQuestionView! {
        didSet {
            questionView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var acceptButton: UIButton! {
        didSet {
            acceptButton.addTarget(self, action: #selector(self.acceptButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var unacceptButton: UIButton! {
        didSet {
            unacceptButton.addTarget(self, action: #selector(self.unacceptButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var startTimerButton: UIButton! {
        didSet {
            startTimerButton.addTarget(self, action: #selector(self.startTimerButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var acceptOrUnacceptTitleLabel: UILabel!
    
    var model: GameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.setup()
        
        if let vc = InterimResultViewController.storyboardInstance {
            
            let player1 = PlayerResult(player: Player(name: "12", avatarKey: "1"), result: 2)
            let player2 = PlayerResult(player: Player(name: "123", avatarKey: "2"), result: 1)
            let player3 = PlayerResult(player: Player(name: "1e23", avatarKey: "3"), result: 5)
            let player4 = PlayerResult(player: Player(name: "12e3", avatarKey: "4"), result: 10)
            
            vc.model = GameResult(players: [player1, player2, player3, player4])
            vc.currentRound = 1
            present(vc, animated: true, completion: nil)
        }
    }
    
    private func setupVisibilityOfStartButton(isVisibly: Bool) {
        startTimerButton.isHidden = !isVisibly
        acceptButton.isHidden = isVisibly
        unacceptButton.isHidden = isVisibly
        acceptOrUnacceptTitleLabel.isHidden = isVisibly
    }
}

extension GameViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .game
}

@objc extension GameViewController {
    private func startTimerButtonAction() {
        model.startTimer()
    }
    private func acceptButtonAction() {
        model.acceptQuestion()
    }
    private func unacceptButtonAction() {
        model.unacceptQuestion()
    }
}

extension GameViewController: GameModelUIDelegate {
    func setCountDownLabel(_ time: String) {
        questionView.countDownLabel.text = time
    }
    
    func setTimeIsOver() {
        questionView.countDownLabel.text = "Time is Over!"
    }
    
    func setPlayerInfo(_ player: Player, question: String) {
        setupVisibilityOfStartButton(isVisibly: true)
        questionView.questionLabel.text = question
        questionView.playerNameLabel.text = player.name
        questionView.avatarImageView.image = AvatarStore.avatar(for: player.avatarKey)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func roundIsOver(with result: GameResult) {
        if let vc = InterimResultViewController.storyboardInstance {
            vc.model = result
            vc.currentRound = model.currentRound
            present(vc, animated: true, completion: nil)
        }
    }
    
    func gameIsOver(with result: GameResult) {
        
    }
    
    func hideStartButton() {
        setupVisibilityOfStartButton(isVisibly: false)
    }
}
