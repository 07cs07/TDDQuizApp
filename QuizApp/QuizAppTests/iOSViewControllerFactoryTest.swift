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
    
    func test_questionViewController_createsControllerWithQuestionAndOptions() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
        XCTAssertEqual(controller.question, "Q1")
        XCTAssertEqual(controller.options, options)
    }
}
