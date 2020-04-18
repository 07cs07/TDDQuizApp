//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 14/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit
import XCTest
@testable import QuizApp
import QuizEngine

class NavigationControllerTests: XCTestCase {
  let navigationController = NotAnimatableNavigationController()
  let factory: ViewControllerFactoryStub = ViewControllerFactoryStub()
  lazy var sut: NavigationControllerRouter = {
    print("imlazy")
    return NavigationControllerRouter(self.navigationController, factory: self.factory)
  }()

  func test_routeToQuestionTwice_navigatesToCorrectViewControllerPassed() {
    
    let viewController = UIViewController()
    let secondViewController = UIViewController()
    factory.stub(viewController, with: .singleAnswer("Q1"))
    factory.stub(secondViewController, with: .multipleAnswer("Q2"))
    print(self.sut)
    sut.routeTo(question: .singleAnswer("Q1"), answerCallback: { _ in })
    sut.routeTo(question: .multipleAnswer("Q2"), answerCallback: { _ in })
    
    XCTAssertEqual(navigationController.viewControllers.count, 2)
    XCTAssertEqual(navigationController.viewControllers.first, viewController)
    XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
  }
  
  func test_routeToQuestionOnce_firesCorrectCallBackPassed() {
    print(self.sut)
    var callBackWasFired = false
    
    sut.routeTo(question: .singleAnswer("Q1"), answerCallback: { _ in callBackWasFired = true })
    factory.answerCallback[.singleAnswer("Q1")]?(["anything!!"])
    
    XCTAssertTrue(callBackWasFired)
  }
  
//  func test_routeToResultTwice_navigatesToCorrectViewControllerPassed() {
//
//    let viewController = UIViewController()
//    let secondViewController = UIViewController()
//    factory.stub(viewController, with: .singleAnswer("Q1"))
//    factory.stub(secondViewController, with: .multipleAnswer("Q2"))
//    print(self.sut)
//    sut.routeTo(question: .singleAnswer("Q1"), answerCallback: { _ in })
//    sut.routeTo(question: .multipleAnswer("Q2"), answerCallback: { _ in })
//
//    XCTAssertEqual(navigationController.viewControllers.count, 2)
//    XCTAssertEqual(navigationController.viewControllers.first, viewController)
//    XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
//  }
}

class NotAnimatableNavigationController: UINavigationController {
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    super.pushViewController(viewController, animated: false)
  }
}

class ViewControllerFactoryStub: ViewControllerFactory {
  private var questionViewControllerStub = [Question<String>: UIViewController]()
  var answerCallback = [Question<String>: ([String]) -> Void]()
  
  func stub(_ viewController: UIViewController, with question: Question<String>) {
    questionViewControllerStub[question] = viewController
  }
  
  func stub(_ viewController: UIViewController, with result: Result<Question<String>, [String]>) {
//    questionViewControllerStub[result] = viewController
  }
  
  func questionViewController(for question: Question<String>, answerCallback: @escaping (([String]) -> Void)) -> UIViewController {
    self.answerCallback[question] = answerCallback
    return self.questionViewControllerStub[question] ?? UIViewController()
  }
  
  func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
    return UIViewController()
  }

}
//
//extension Result : Hashable {
//  init(answers:[Question: Answer], score: Int) {
//    self.answers = answers
//    self.score = score
//  }
//
//  public var hashValue: Int {
//    return 1
//  }
//
//  public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
//    return lhs.score == rhs.score
//  }
//}
