//
//  QuestionTests.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 14/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionTests: XCTestCase {
  
  func test_hashValue_returnsAnswerHashValue() {
    XCTAssertEqual(Question.singleAnswer("a answer").hashValue, "a answer".hashValue)
    XCTAssertEqual(Question.multipleAnswer("a answer").hashValue, "a answer".hashValue)
  }
  
  func test_equal_singleAnswer() {
    XCTAssertEqual(Question.singleAnswer("a answer"), Question.singleAnswer("a answer"))
    XCTAssertEqual(Question.multipleAnswer("a answer"), Question.multipleAnswer("a answer"))
    XCTAssertEqual(Question.multipleAnswer(["a answer"]), Question.multipleAnswer(["a answer"]))
  }
  
  func test_NotEqual_singleAnswer() {
    XCTAssertNotEqual(Question.singleAnswer("a answer"), Question.singleAnswer("a another answer"))
    XCTAssertNotEqual(Question.multipleAnswer("a answer"), Question.multipleAnswer("another answer"))
    XCTAssertNotEqual(Question.singleAnswer("a answer"), Question.multipleAnswer("a answer"))
    XCTAssertNotEqual(Question.singleAnswer("a answer"), Question.multipleAnswer("another answer"))
  }
}
