//
//  CoreDataQuestionsProvider.swift
//  5second
//
//  Created by Maximal Mac on 31.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation
import CoreData

class CoreDataQuestionsProvider: QuestionProvider {
    
    private var questions: [QuestionCD] = []
    private var currentIndex: Int = 0
    
    init() {
        let fetchRequest: NSFetchRequest<QuestionCD> = QuestionCD.fetchRequest()
        let sort = NSSortDescriptor(key: "count", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do {
            questions = try DatabaseHelper.shared.managedObjectContext.fetch(fetchRequest)
        } catch {
            let errorStr = error.localizedDescription
            VZLogger.error("core data init error - \(errorStr)")
        }
    }
    
    func question() -> QuestionCD {
        if currentIndex >= questions.count {
            currentIndex = 0
        }
        let question = questions[currentIndex]
        currentIndex += 1
        increaseCounter(for: question)
        return question
    }
    
    func totalQuestion() -> Int {
        return questions.count
    }
    
    func increaseCounter(for question: QuestionCD) {
        question.count += 1
        DatabaseHelper.shared.saveContext()
    }
}
