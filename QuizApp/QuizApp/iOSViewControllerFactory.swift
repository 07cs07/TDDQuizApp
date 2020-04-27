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
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    private let correctAnswers: [Question<String>: [String]]
    
    init(questions: [Question<String>], options: [Question<String>: [String]], correctAnswers: [Question<String>: [String]]) {
        self.questions = questions
        self.options = options
        self.correctAnswers = correctAnswers
    }
        
    func questionViewController(for question: Question<String>, answerCallback: @escaping (([String]) -> Void)) -> UIViewController {
        guard let options = options[question] else {
            fatalError("it is not allowed to have a question: \(question) with not options")
        }
        return questionViewController(question: question, options: options, answerCallback: answerCallback)
    }
    
    private func questionViewController(question: Question<String>, options: [String],  answerCallback: @escaping (([String]) -> Void)) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return questionViewController(for: question, value:  value, options: options, allowsMultipleSelection: false, answerCallback: answerCallback)
            
        case .multipleAnswer(let value):
            return questionViewController(for: question, value: value, options: options, allowsMultipleSelection: true, answerCallback: answerCallback)
        }
    }
    
    private func questionViewController(for question: Question<String>, value: String, options: [String], allowsMultipleSelection: Bool, answerCallback: @escaping (([String]) -> Void)) -> QuestionViewController {
        let questionPresenter = QuestionPresenter(questions: questions, currentQuestion: question)
        let controller = QuestionViewController(question: value, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: answerCallback)
        controller.title = questionPresenter.title
        return controller
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        let resultPresenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let controller = ResultsViewController(summary: resultPresenter.summary, answers: resultPresenter.answers)
        controller.title = resultPresenter.title
        return controller
    }
}
