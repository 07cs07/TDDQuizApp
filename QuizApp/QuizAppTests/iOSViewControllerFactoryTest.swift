//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 16/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    let question = Question.singleAnswer("Q1")
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswersQuestionType_createsControllerWithQuestionAndOptions() {
        
        let controller = makeQuestionViewController()
        XCTAssertEqual(controller.question, "Q1")
        XCTAssertEqual(controller.options, options)
        XCTAssertEqual(controller.tableView.allowsMultipleSelection, false)
    }
    
    func test_questionViewController_multipleAnswersQuestionType_createsQuestionController() {
        let question = Question.multipleAnswer("Q1")
        let controller = makeQuestionViewController(question: question)
        XCTAssertEqual(controller.question, "Q1")
        XCTAssertEqual(controller.options, options)
        XCTAssertEqual(controller.tableView.allowsMultipleSelection, true)
    }
    
    // MARK: - Helpers
    
    func makeSUT(question: Question<String> = Question.singleAnswer("Q1"), options: [String] = ["A1", "A2"]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: [question: options])
    }
    
    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {
        let controller = makeSUT(question: question).questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
        _ = controller.view
        return controller
    }
}
