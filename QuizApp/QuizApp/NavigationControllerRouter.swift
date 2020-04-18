//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 14/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
  private let navigationController: UINavigationController
  private let factory: ViewControllerFactory
  
  init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
    self.navigationController = navigationController
    self.factory = factory
  }
  
  func routeTo(result: Result<Question<String>, [String]>) {
    show(factory.resultViewController(for: result))
  }
  
  func routeTo(question: Question<String>, answerCallback: @escaping (([String]) -> Void)) {
    show(factory.questionViewController(for: question, answerCallback: answerCallback))
  }
  
  private func show(_ viewController: UIViewController) {
    navigationController.pushViewController(viewController, animated: true)
  }

}
