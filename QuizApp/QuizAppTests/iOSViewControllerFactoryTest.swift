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
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswersQuestionType_createsControllerWithQuestionAndOptions() {
        let controller = makeQuestionViewController(question: singleAnswerQuestion)
        XCTAssertEqual(controller.question, "Q1")
        XCTAssertEqual(controller.title, "Question #1")
        XCTAssertEqual(controller.options, options)
        XCTAssertEqual(controller.allowsMultipleSelection, false)
    }
    
    func test_questionViewController_multipleAnswersQuestionType_createsQuestionController() {
        let controller = makeQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertEqual(controller.question, "Q2")
        XCTAssertEqual(controller.options, options)
        XCTAssertEqual(controller.allowsMultipleSelection, true)
    }
    
    func test_questionViewController_withTotalTwoQuestions_rendersTitle() {

        let controller = makeQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertEqual(controller.title, "Question #2")
    }
    
    // MARK: - Helpers
    
    func makeSUT(question: Question<String> = Question.singleAnswer("Q1")) -> iOSViewControllerFactory {
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        return iOSViewControllerFactory(questions: questions, options: [question: options])
    }
    
    func makeQuestionViewController(question: Question<String>) -> QuestionViewController {
        let controller = makeSUT(question: question).questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
        _ = controller.view
        return controller
    }
}
