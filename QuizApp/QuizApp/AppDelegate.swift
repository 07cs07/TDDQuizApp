//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 06/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit
import QuizEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var game: Game<NavigationControllerRouter>?
    private let navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureWindow()
        setupQuizGame()
        return true
    }
    
    private func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

private extension AppDelegate {
    func createQuestionSet() -> (questions: [Question<String>], options: [Question<String> : [String]], correctAnswers: [Question<String> : [String]]) {
        let question1 = Question.singleAnswer("What is Mike's nationality?")
        let question2 = Question.multipleAnswer("What are Caio's nationalities?")
        let questions = [question1, question2]
        
        let option1 = "American"
        let option2 = "Greek"
        let option3 = "Canadian"
        
        let option4 = "Brazilian"
        let option5 = "Russian"
        let option6 = "Portuguese"
        
        let options = [question1: [option1, option2, option3], question2: [option2, option4, option5, option6]]
        
        let correctAnswers = [question1: [option2], question2: [option4, option6]]
        
        return (questions, options, correctAnswers)
    }
    
    func setupQuizGame() {
        let questionSet = createQuestionSet()
        let factory = iOSViewControllerFactory(questions: questionSet.questions, options: questionSet.options, correctAnswers: questionSet.correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)
        game = startGame(questions: questionSet.questions, router: router, correctAnswers: questionSet.correctAnswers)
    }
}

