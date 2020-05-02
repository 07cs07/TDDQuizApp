//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Mahalingam, Balachander on 02/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
  let router = RouterSpy()
  
  func test_start_withNoQuestions_doesNotRouteToQuestion() {
    makeSUT(questions: []).start()
    XCTAssertTrue(router.routedQuestions.isEmpty)
  }

  func test_start_withOneQuestion_routeToQuestion() {
    makeSUT(questions: ["Q1"]).start()
    XCTAssertEqual(router.routedQuestions.count, 1)
  }
  
  func test_start_withOneQuestion_routeToCorrectQuestion() {
    makeSUT(questions: ["Q1"]).start()
    XCTAssertEqual(router.routedQuestions, ["Q1"])
  }
  
  func test_start_withOneQuestion_routeToCorrectQuestion_2() {
    makeSUT(questions: ["Q2"]).start()
    XCTAssertEqual(router.routedQuestions, ["Q2"])
  }
  
  func test_start_withTwoQuestions_routeToCorrectQuestion() {
    makeSUT(questions: ["Q1", "Q2"]).start()
    XCTAssertEqual(router.routedQuestions, ["Q1"])
  }
  
  func test_startTwice_withTwoQuestions_routeToCorrectQuestion() {
    let sut = makeSUT(questions: ["Q1", "Q2"])
    sut.start()
    sut.start()
    XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
  }
  
  func test_start_withTwoQuestionsAndAnswer1stQuestion_routeToSecondQuestion() {
    makeSUT(questions: ["Q1", "Q2"]).start()
    router.answerCallback("A1")
    XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
  }
  
  func test_start_withThreeQuestionsAndAnswer1stTwoQuestions_routesToSecondAndThirdQuestion() {
    makeSUT(questions: ["Q1", "Q2", "Q3"]).start()
    router.answerCallback("A1")
    router.answerCallback("A2")
    XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
  }
  
  func test_start_withOneQuestionAndAnswer1stQuestion_routesToNoQuestion() {
    makeSUT(questions: ["Q1"]).start()
    router.answerCallback("A1")
    XCTAssertEqual(router.routedQuestions, ["Q1"])
  }
  
  func test_start_withNoQuestion_routeToResult() {
    makeSUT(questions: []).start()
    XCTAssertEqual(router.routedResult!.answers, [:])
  }
  
  func test_start_withOneQuestionAndAnswer1stQuestion_routesToResult() {
    makeSUT(questions: ["Q1"]).start()
    router.answerCallback("A1")
    XCTAssertEqual(router.routedResult?.answers, ["Q1": "A1"])
  }
  
  func test_start_withTwoQuestionsAndAnswer1stTwoQuestions_routesToResult() {
    makeSUT(questions: ["Q1", "Q2"]).start()
    router.answerCallback("A1")
    router.answerCallback("A2")
    XCTAssertEqual(router.routedResult?.answers, ["Q1" : "A1", "Q2" : "A2"])
  }
  
  func test_start_withOneQuestion_doesNotRoutesToResult() {
    makeSUT(questions: ["Q1"]).start()
    XCTAssertNil(router.routedResult)
  }
  
  func test_start_withTwoQuestionsAndAnswer1stQuestion_doesNotRoutesToResult() {
    makeSUT(questions: ["Q1", "Q2"]).start()
    router.answerCallback("A1")
    XCTAssertNil(router.routedResult)
  }
  
  func test_start_withTwoQuestionsAndAnswer1stTwoQuestions_scores() {
    makeSUT(questions: ["Q1", "Q2"]).start()
    router.answerCallback("A1")
    router.answerCallback("A2")
    XCTAssertEqual(router.routedResult?.score, 0)
  }
  
  func test_start_withTwoQuestionsAndAnswer1stTwoQuestions_scoresWithRightAnswers() {
    var receivedAnswers = [String:String]()
    let sut = makeSUT(questions: ["Q1", "Q2"]) { answers in
      receivedAnswers = answers
      return 10
    }
    sut.start()
    router.answerCallback("A1")
    router.answerCallback("A2")
    XCTAssertEqual(receivedAnswers, ["Q1" : "A1", "Q2" : "A2"])
  }
  
  // MARKS:- Helpers
  private func makeSUT(questions: [String], scoring: @escaping (([String: String]) -> Int) = { _ in 0 }) -> Flow<RouterSpy> {
    return Flow(questions: questions, router: router, scoring: scoring)
  }
}
