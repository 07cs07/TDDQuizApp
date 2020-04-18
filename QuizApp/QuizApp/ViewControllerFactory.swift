//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 16/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
  func questionViewController(for question: Question<String>, answerCallback: @escaping (([String]) -> Void)) -> UIViewController
  func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}

class iOSViewControllerFactory: ViewControllerFactory {
    var options: [Question<String>: [String]] = [:]
    
    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping (([String]) -> Void)) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options[question]!, selection: answerCallback)
        default:
            return UIViewController()
        }
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
