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
    let text: String = ""
    let counter: Int = 0
}

protocol QuestionProvider: class {
    func question() -> Question
    func totalQuestion() -> Int
    func increaseCounter(for question: Question)
}

class QuestionProviderEngine: QuestionProvider {
    func question() -> Question {
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
    let timerTime: Int
    
    var timeIsOver: (() -> Void)?
    
    init(questionProvider: QuestionProvider, timerTime: Int) {
        self.questionProvider = questionProvider
        self.timerTime = timerTime
        setNextQuestion()
    }
    
    func question() -> String {
        return currentQuestion.text
    }
    
    func setNextQuestion() {
        self.currentQuestion = questionProvider.question()
    }
}

class GameModel {
    private let engine: GameEngine
    private let players: [Player]
    private(set) var result: GameResult
    private(set) var currentRound: Int = 0
    private(set) var currentPlayerIndex: Int = 0
    
    init(players: [Player], engine: GameEngine) {
        self.engine = engine
        self.players = players
        
        var playersResults = [PlayerResult]()
        
        players.forEach { playersResults.append(PlayerResult(player: $0, result: 0)) }
        result = GameResult(players: playersResults)
    }
    
    func acceptQuestion() {
        
    }
    
    func unacceptQuestion() {
        
    }
}
