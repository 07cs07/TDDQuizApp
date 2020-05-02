//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Mahalingam, Balachander on 11/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import QuizEngine

class RouterSpy: Router {

  var routedQuestions: [String] = []
  var routedResult: Result<String, String>? = nil
  var answerCallback: AnswerHandler = { _ in }
  
  func routeTo(question: String, answerCallback: @escaping ((String) -> Void)) {
    routedQuestions.append(question)
    self.answerCallback = answerCallback
  }
  
  func routeTo(result: Result<String, String>) {
    self.routedResult = result
  }
}
