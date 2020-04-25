//
//  QuestionPresenterTest.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 22/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class QuestionPresenterTest: XCTestCase {
    let questions = [Question.singleAnswer("Q1"), Question.multipleAnswer("Q2"), Question.singleAnswer("Q3"), Question.multipleAnswer("Q4")]
    
    func test_title_for1StQuestion() {
        let currentQuestion = Question.singleAnswer("Q1")
        let sut = QuestionPresenter(questions: questions, currentQuestion: currentQuestion)
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion() {
        let currentQuestion = Question.multipleAnswer("Q2")
        let sut = QuestionPresenter(questions: questions, currentQuestion: currentQuestion)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forNonExcistingQuestion() {
        let currentQuestion = Question.singleAnswer("Q5")
        let sut = QuestionPresenter(questions: questions, currentQuestion: currentQuestion)
        XCTAssertEqual(sut.title, "")
    }
}
