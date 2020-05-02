//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Mahalingam, Balachander on 14/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerTests: XCTestCase {
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    let navigationController = NotAnimatableNavigationController()
    let factory: ViewControllerFactoryStub = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()
    
    func test_routeToQuestionTwice_navigatesToCorrectViewControllerPassed() {
        let viewController = UIViewController()
        factory.stub(viewController, with: singleAnswerQuestion)
        let secondViewController = UIViewController()
        factory.stub(secondViewController, with: multipleAnswerQuestion)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_singleAnswer_answerCallback_progressToNextQuestion() {
        var callBackWasFired = false
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in callBackWasFired = true })
        factory.answerCallback[singleAnswerQuestion]?(["anything!!"])
        
        XCTAssertTrue(callBackWasFired)
    }
    
    func test_routeToQuestion_singleAnswerQuestion_doesnotConfigureViewControllerWithSubmitButton() {
        let controller = UIViewController()
        factory.stub(controller, with: singleAnswerQuestion)
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
        XCTAssertNil(controller.navigationItem.rightBarButtonItem)
        factory.answerCallback[singleAnswerQuestion]?(["anything!!"])
        XCTAssertNil(controller.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswer_answerCallback_doesnotProgressToNextQuestion() {
        var callBackWasFired = false
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in callBackWasFired = true })
        factory.answerCallback[multipleAnswerQuestion]?([])
        
        XCTAssertFalse(callBackWasFired)
    }
    
    func test_routeToQuestion_multipleAnswer_submitButton_isDisabledWhenZeroAnswerSelected() {
        let controller = UIViewController()
        factory.stub(controller, with: multipleAnswerQuestion)
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        XCTAssertFalse(controller.navigationItem.rightBarButtonItem!.isEnabled)
        factory.answerCallback[multipleAnswerQuestion]?(["A1"])
        XCTAssertTrue(controller.navigationItem.rightBarButtonItem!.isEnabled)
        factory.answerCallback[multipleAnswerQuestion]?([])
        XCTAssertFalse(controller.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToQuestion_multipleAnswer_submitButton_firesAnswerCallback() {
        let controller = UIViewController()
        var callBackWasFired = false
        factory.stub(controller, with: .multipleAnswer("Q1"))
        sut.routeTo(question: .multipleAnswer("Q1"), answerCallback: { _ in callBackWasFired = true })
        factory.answerCallback[.multipleAnswer("Q1")]?(["A1"])
        controller.navigationItem.rightBarButtonItem?.simulateTap()
        XCTAssertTrue(callBackWasFired)
        
    }
    
    func test_routeToResultTwice_navigatesToCorrectViewControllerPassed() {
        let viewController = UIViewController()
        factory.stub(viewController, with: singleAnswerQuestion)
        
        let secondViewController = UIViewController()
        factory.stub(secondViewController, with: multipleAnswerQuestion)
        
        sut.routeTo(question: singleAnswerQuestion, answerCallback: { _ in })
        sut.routeTo(question: multipleAnswerQuestion, answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
}

// MARK: Helpers

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


private extension UIBarButtonItem {
    func simulateTap() {
        self.target?.performSelector(onMainThread: self.action!, with: nil, waitUntilDone: true)
        
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
