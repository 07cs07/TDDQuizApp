//
//  Question.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 14/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation

enum Question<T: Hashable> : Hashable {
  case singleAnswer(T)
  case multipleAnswer(T)
  
  var hashValue: Int {
    
    switch self {
    case .singleAnswer(let value):
      return value.hashValue
    case .multipleAnswer(let value):
      return value.hashValue
    }
  }
  
  static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
    switch (lhs, rhs) {
    case (.singleAnswer(let lhs), .singleAnswer(let rhs)):
      return lhs == rhs
    case (.multipleAnswer(let lhs), .multipleAnswer(let rhs)):
      return lhs == rhs
    default:
      return false
    }
  }
}
