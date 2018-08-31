//
//  CoreDataInitHelper.swift
//  5second
//
//  Created by Maximal Mac on 31.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//

import Foundation
import CoreData

class CoreDataInitHelper {
    class func initCoreDataIfNeeded() {
        let fetchRequest: NSFetchRequest<QuestionCD> = QuestionCD.fetchRequest()
        do {
            let objects = try DatabaseHelper.shared.managedObjectContext.fetch(fetchRequest)
            let questions = CoreDataInitHelper.questions()
            if objects.count == 0 {
                CoreDataInitHelper.initCoreData(with: questions)
            } else if objects.count < questions.count {
                let _questions = Array(questions[objects.count...])
                CoreDataInitHelper.initCoreData(with: _questions)
            }
        } catch {
            let errorStr = error.localizedDescription
            VZLogger.error("core data init error - \(errorStr)")
        }
    }
    
    private class func initCoreData(with questions: [String]) {
        questions.forEach { (question) in
            let cdObject = QuestionCD(context: DatabaseHelper.shared.managedObjectContext)
            cdObject.text = question
            cdObject.count = 0            
        }
        DatabaseHelper.shared.saveContext()
    }
    
    private class func questions() -> [String] {
        return QuestionInitDataProvider().questions
    }
}
