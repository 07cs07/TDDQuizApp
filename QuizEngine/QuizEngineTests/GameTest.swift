//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Mahalingam, Balachander on 11/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class GameTest: XCTestCase {
    let router = RouterSpy()
    var game: Game<RouterSpy>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutTwoQuestionsCorrectly_scoresZero() {
        router.answerCallback("wrong")
        router.answerCallback("wrong")
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutTwoQuestionsCorrectly_scoresOne() {
        router.answerCallback("A1")
        router.answerCallback("wrong")
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutTwoQuestionsCorrectly_scoresTwo() {
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
}
