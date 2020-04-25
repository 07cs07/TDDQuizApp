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
    switch question {
    case .singleAnswer(_):
        show(factory.questionViewController(for: question, answerCallback: answerCallback))
    case .multipleAnswer(_):
        let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
        let buttonController = SubmitBottonController(button: button, callback: answerCallback)
        let controller = factory.questionViewController(for: question, answerCallback: { model in
            buttonController.update(model)
        })
        controller.navigationItem.rightBarButtonItem = buttonController.button
        show(controller)
    }
    
  }
  
  private func show(_ viewController: UIViewController) {
    navigationController.pushViewController(viewController, animated: true)
  }

}

private class SubmitBottonController: NSObject {
    let button: UIBarButtonItem
    let callback: ([String]) -> Void
    var model: [String] = []
    
    init(button: UIBarButtonItem, callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        self.setup()
    }
    
    private func setup() {
        self.button.target = self
        self.button.action = #selector(fireCallback)
        updateButtonState()
    }
    
    func update(_ model: [String]) {
        self.model = model
        updateButtonState()
    }
    
    private func updateButtonState() {
        button.isEnabled = model.count > 0
    }
    
    @objc func fireCallback() {
        callback(model)
    }
}
