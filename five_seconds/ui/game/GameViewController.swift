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
        
    }
    
    func gameIsOver(with result: GameResult) {
        
    }
    
    func hideStartButton() {
        setupVisibilityOfStartButton(isVisibly: false)
    }
}
