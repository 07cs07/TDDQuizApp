//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 16/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
  func questionViewController(for question: Question<String>, answerCallback: @escaping (([String]) -> Void)) -> UIViewController
  func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}
