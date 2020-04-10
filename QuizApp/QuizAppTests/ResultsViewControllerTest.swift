//
//  ResultsViewControllerTest.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 09/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import XCTest
@testable import QuizApp

class ResultsViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        XCTAssertEqual(makeSUT(summary: "a Summary").headerLabel.text, "a Summary")
    }
    
    func test_viewDidLoad_withAnswers_renderAnswer() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
        
    func test_viewDidLoad_withCorrectAnswer_rendersCorrectAnswer() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_rendersWrongAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", answer: "A1", isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
    }
        
//    MARK:- Helpers
    private func makeSUT(summary: String = "", answers: [PresantableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeDummyAnswer() -> PresantableAnswer {
        return makeAnswer(isCorrect: false)
    }
    
    private func makeAnswer(question: String = "", answer: String = "", isCorrect: Bool) -> PresantableAnswer {
        return PresantableAnswer(question: question, answer: answer, isCorrect: isCorrect)
    }
}
