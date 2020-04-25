//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 16/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    var options: [Question<String>:[String]] {
        return [singleAnswerQuestion:["A1", "A2"], multipleAnswerQuestion:["A1", "A2"]]
    }
    var correctAnswers: [Question<String>:[String]] {
        return [singleAnswerQuestion:["A1"], multipleAnswerQuestion:["A1", "A2"]]
    }
    var questions: [Question<String>] {
        return [singleAnswerQuestion, multipleAnswerQuestion]
    }
    
    func test_questionViewController_singleAnswersQuestionType_createsControllerWithQuestionAndOptions() {
        let controller = makeQuestionViewController(for: singleAnswerQuestion)
        XCTAssertEqual(controller.question, "Q1")
        XCTAssertEqual(controller.title, "Question #1")
        XCTAssertEqual(controller.options, options[singleAnswerQuestion])
        XCTAssertEqual(controller.tableView.allowsMultipleSelection, false)
    }
    
    func test_questionViewController_multipleAnswersQuestionType_createsQuestionController() {
        let controller = makeQuestionViewController(for: multipleAnswerQuestion)
        XCTAssertEqual(controller.question, "Q2")
        XCTAssertEqual(controller.options, options[multipleAnswerQuestion])
        XCTAssertEqual(controller.tableView.allowsMultipleSelection, true)
    }
    
    func test_questionViewController_withTotalTwoQuestions_rendersTitle() {

        let controller = makeQuestionViewController(for: multipleAnswerQuestion)
        XCTAssertEqual(controller.title, "Question #2")
    }
    
    func test_resultViewController_createControllerWithSummary() {
        XCTAssertEqual(makeResultSUT().controller.summary, makeResultSUT().presenter.summary)
    }
    
    func test_resultViewController_createControllerWithAnswer() {
        XCTAssertEqual(makeResultSUT().controller.answers.count, makeResultSUT().presenter.answers.count)
    }
    
    // MARK: - Helpers
    
    func makeSUT(question: Question<String>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: questions, options: options, correctAnswers: correctAnswers)
    }
    
    func makeQuestionViewController(for question: Question<String>) -> QuestionViewController {
        let controller = makeSUT(question: question).questionViewController(for: question, answerCallback: {_ in }) as! QuestionViewController
        _ = controller.view
        return controller
    }
    
    func makeResultSUT() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let result = Result(score: 2, answers:[singleAnswerQuestion:["A1"], multipleAnswerQuestion:["A1", "A2"]])
         let sut = makeSUT(question: singleAnswerQuestion)
        
         let resultPresenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
         let resultViewController = sut.resultViewController(for: result) as! ResultsViewController
        return (resultViewController, resultPresenter)
    }
}
