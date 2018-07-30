//
//  GameModel.swift
//  5second
//
//  Created by Maximal Mac on 19.07.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation

class Question {
    let id: Int = 0
    var text: String = ""
    let counter: Int = 0
}

protocol QuestionProvider: class {
    func question() -> Question
    func totalQuestion() -> Int
    func increaseCounter(for question: Question)
}

class QuestionProviderEngine: QuestionProvider {
    
    var index: Int = 0
    
    func question() -> Question {
        let question = Question()
        question.text = "\(index)"
        index += 1
        return Question()
    }
    
    func totalQuestion() -> Int {
        return 0
    }
    
    func increaseCounter(for question: Question) {
        
    }
}

class GameEngine {
    private let questionProvider: QuestionProvider
    private(set) var currentQuestion: Question!
    private var timer: Timer?
    private var countDown: Int = 0
    let timerTime: Int
    
    var timeIsOver: (() -> Void)?
    var updateTime: ((_ time: Int) -> Void)?
    
    init(questionProvider: QuestionProvider, timerTime: Int) {
        self.questionProvider = questionProvider
        self.timerTime = timerTime
    }
    
    func question() -> String {
        self.currentQuestion = questionProvider.question()
        return currentQuestion.text
    }
    
    func setupTimer() {
        countDown = timerTime + 1
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true, block: { [weak self] (_) in
            self?.countDown -= 1
            if self?.countDown == 0 {
                self?.timeIsOverAction()
            } else {
                self?.countDownAction(with: self?.countDown ?? 0)
            }
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func timeIsOverAction() {
        stopTimer()
        self.timeIsOver?()
    }
    
    private func countDownAction(with time: Int){
        self.updateTime?(time)
    }
    
    deinit {
        timer?.invalidate()
        print("deinit - GameEngine")
    }
}

protocol GameModelUIDelegate: class {
    func setCountDownLabel(_ time: String)
    func setTimeIsOver()
    func setPlayerInfo(_ player: Player, question: String)
    func setTitle(_ title: String)
    
    func roundIsOver(with result: GameResult)
    func gameIsOver(with result: GameResult)
}

class GameModel {
    enum GameState: Int {
        case initial
        case setNextPlayer
        case waitStart
        case countdown
        case timeIsOver
        case gameIsOver
    }
    
    private let engine: GameEngine
    private let players: [Player]
    private(set) var result: GameResult
    let totalRounds: Int = 9
    private(set) var currentRound: Int = 1
    private(set) var currentPlayerIndex: Int = 0
    private var state: GameState = .initial
    
    weak var delegate: GameModelUIDelegate?
    
    init(players: [Player], engine: GameEngine) {
        self.engine = engine
        self.players = players
        
        var playersResults = [PlayerResult]()
        
        players.forEach { playersResults.append(PlayerResult(player: $0, result: 0)) }
        result = GameResult(players: playersResults)
        
        engine.timeIsOver = { [weak self] in
            self?.state = .timeIsOver
            self?.handle()
        }
        
        engine.updateTime = { [weak self] (time) in
            self?.delegate?.setCountDownLabel("\(time)")
        }
    }
    
    func setup() {
        handle()
    }
    
    func acceptQuestion() {
        self.state = .setNextPlayer
        result.players[currentPlayerIndex].result += 1
        handle()
    }
    
    func unacceptQuestion() {
        self.state = .setNextPlayer
        handle()
    }
    
    func startTimer() {
        handle()
    }
    
    private func handle() {
        switch state {
        case .initial:
            setQuestion()
            state = .waitStart
        case .setNextPlayer:
            setNextPlayer()
            setQuestion()
            state = .waitStart
        case .waitStart:
            engine.setupTimer()
            state = .countdown
        case .countdown:
            return
        case .timeIsOver:
            delegate?.setTimeIsOver()
        case .gameIsOver:
            return
        }
    }
    
    private func setQuestion() {
        let question = engine.question()
        delegate?.setPlayerInfo(players[currentPlayerIndex], question: question)
        delegate?.setTitle("round: \(currentRound)")
    }
    
    private func setNextPlayer() {
        var nextPlayerIndex = currentPlayerIndex + 1
        if nextPlayerIndex == players.count {
            nextPlayerIndex = 0
            roundIsOver()
            let nextRound = currentRound + 1
            if nextRound > totalRounds {
                gameIsOver()
                return
            }
            currentRound = nextRound
            delegate?.setTitle("\(currentRound)")
        }
        currentPlayerIndex = nextPlayerIndex
    }
    
    private func gameIsOver() {
        state = .gameIsOver
        self.delegate?.gameIsOver(with: result)
    }
    
    private func roundIsOver() {
        self.delegate?.roundIsOver(with: result)
    }
}
