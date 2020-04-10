//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 06/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let viewController = ResultsViewController(summary: "A Summary", answers: [
        PresantableAnswer(question: "Question 1Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1", answer: "Correct Answer Correct Answer Correct Answer Correct Answer Correct Answer Correct Answer Correct Answer Correct Answer", wrongAnswer: nil),
        PresantableAnswer(question: "Question 1", answer: "Im Correct", wrongAnswer: "Wrong Answer"),
    ])
    _ = viewController.view
    
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
    return true
  }

  // MARK: UISceneSession Lifecycle
@available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
@available(iOS 13.0, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

