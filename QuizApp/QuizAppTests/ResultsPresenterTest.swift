//
//  ResultsPresenterTest.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 20/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine
@testable import QuizApp

class ResultsPresenterTest: XCTestCase {
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    func test_summary_withThreeQuestionsAndScoreTwo_returnsSummary() {
        let result = Result(score: 2, answers: [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]])
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 2/2 questions correct")
    }

    func test_presentableAnswers_whenNoQuestions_isEmpty() {
        let emptyAnswers = [Question<String>:[String]]()
        let result = Result(score: 0, answers: emptyAnswers)
        let sut = ResultsPresenter(result: result,  correctAnswers: [:])
        XCTAssertTrue(sut.answers.isEmpty)
    }
    
    func test_presentableAnswers_withSingleAnswers_answeredCorrect_mapsAnswer() {
        let result = Result(score: 0, answers: [singleAnswerQuestion: ["A2"]])
        let sut = ResultsPresenter(result: result, correctAnswers: [singleAnswerQuestion: ["A2"]])
        XCTAssertEqual(sut.answers.count, 1)
        XCTAssertEqual(sut.answers.first!.question, "Q1")
        XCTAssertEqual(sut.answers.first!.answer, "A2")
        XCTAssertEqual(sut.answers.first!.wrongAnswer, nil)
    }
    
    func test_presentableAnswers_withSingleAnswers_answeredWrong_mapsAnswer() {
        let result = Result(score: 0, answers: [singleAnswerQuestion: ["A1"]])
        let sut = ResultsPresenter(result: result, correctAnswers: [singleAnswerQuestion: ["A2"]])
        XCTAssertEqual(sut.answers.count, 1)
        XCTAssertEqual(sut.answers.first!.question, "Q1")
        XCTAssertEqual(sut.answers.first!.answer, "A2")
        XCTAssertEqual(sut.answers.first!.wrongAnswer, "A1")
    }
    
    
    func test_presentableAnswers_withMultipleAnswers_answeredWrong_mapsAnswer() {
        let result = Result(score: 0, answers: [multipleAnswerQuestion: ["A1", "A3"]])
        let sut = ResultsPresenter(result: result, correctAnswers: [multipleAnswerQuestion: ["A2", "A3"]])
        XCTAssertEqual(sut.answers.count, 1)
        XCTAssertEqual(sut.answers.first!.question, "Q2")
        XCTAssertEqual(sut.answers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.answers.first!.wrongAnswer, "A1, A3")
    }
    
    func test_presentableAnswers_withMultipleAnswers_answeredCorrect_mapsAnswer() {
        let result = Result(score: 0, answers: [multipleAnswerQuestion: ["A3", "A1"]])
        let sut = ResultsPresenter(result: result, correctAnswers: [multipleAnswerQuestion: ["A1", "A3"]])
        XCTAssertEqual(sut.answers.count, 1)
        XCTAssertEqual(sut.answers.first!.question, "Q2")
        XCTAssertEqual(sut.answers.first!.answer, "A1, A3")
        XCTAssertEqual(sut.answers.first!.wrongAnswer, nil)
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswer() {
        let result = Result(score: 0, answers: [singleAnswerQuestion: ["A4"], multipleAnswerQuestion: ["A3", "A1"]])
        let sut = ResultsPresenter(result: result, correctAnswers: [multipleAnswerQuestion: ["A1", "A3"], singleAnswerQuestion: ["A1"]])
        XCTAssertEqual(sut.answers.count, 2)
        XCTAssertEqual(sut.answers.first!.question, "Q1")
        XCTAssertEqual(sut.answers.first!.answer, "A4")
        XCTAssertEqual(sut.answers.first!.wrongAnswer, nil)
    }
}
