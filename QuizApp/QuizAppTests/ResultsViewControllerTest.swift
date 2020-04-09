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
    
    func test_viewDidLoad_withCorrectAnswer_rendersCorrectAnswerCell() {
        let sut = makeSUT(answers: [PresantableAnswer(isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withWrongAnswer_rendersWrongAnswerCell() {
        let sut = makeSUT(answers: [PresantableAnswer(isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
    }
    
//    MARK:- Helpers
    private func makeSUT(summary: String = "", answers: [PresantableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeDummyAnswer() -> PresantableAnswer {
        return PresantableAnswer(isCorrect: false)
    }
}
