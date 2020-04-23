//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 22/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    var options: [Question<String>: [String]] = [:]
    var questions: [Question<String>] = []
    
    init(questions: [Question<String>], options: [Question<String>: [String]]) {
        self.questions = questions
        self.options = options
    }
        
    func questionViewController(for question: Question<String>, answerCallback: @escaping (([String]) -> Void)) -> UIViewController {
        guard let options = options[question] else {
            fatalError("it is not allowed to have a question: \(question) with not options")
        }
        return questionViewController(question: question, options: options, answerCallback: answerCallback)
    }
    
    fileprivate func questionViewController(question: Question<String>, options: [String],  answerCallback: @escaping (([String]) -> Void)) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return questionViewController(for: question, value:  value, options: options, answerCallback: answerCallback)
            
        case .multipleAnswer(let value):
            let controller = questionViewController(for: question, value: value, options: options, answerCallback: answerCallback)
            _ = controller.view
            controller.tableView.allowsMultipleSelection = true
            return controller
        }
    }
    
    private func questionViewController(for question: Question<String>, value: String, options: [String], answerCallback: @escaping (([String]) -> Void)) -> QuestionViewController {
        let questionPresenter = QuestionPresenter(questions: questions, currentQuestion: question)
        let controller = QuestionViewController(question: value, options: options, selection: answerCallback)
        controller.title = questionPresenter.title
        return controller
    }
    
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
