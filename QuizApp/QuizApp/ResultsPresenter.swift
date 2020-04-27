//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 20/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    let result: Result<Question<String>, [String]>
    let questions: [Question<String>]
    let correctAnswers: [Question<String>: [String]]
    
    var title: String {
        return "Result"
    }
    
    var summary: String {
        return "You got \(result.score)/\(result.answers.count) questions correct"
    }
    
    var answers: [PresantableAnswer] {
        return questions.map { question in
            guard let userAnswer = result.answers[question], let correctAnswer = correctAnswers[question] else {
                fatalError("couldn't find the answer for the question: \(question)")
            }
            return presantableAnswer(question, userAnswer, correctAnswer)
        }
    }
    
    private func presantableAnswer(_ question: Question<String>,_ userAnswer: [String], _ correctAnswers: [String]) -> PresantableAnswer {
        let formattedCorrectAnswer = formattedAnswer(correctAnswers)
        switch question {
        case .singleAnswer(let value):
            let formattedUserAnswer = formattedAnswer(userAnswer)
            let wrongAnswer = formattedCorrectAnswer == formattedUserAnswer ? nil : formattedUserAnswer
            return PresantableAnswer(question: value, answer: formattedCorrectAnswer, wrongAnswer: wrongAnswer)
            
        case .multipleAnswer(let value):
            var userAnsweredCorrectly = userAnswer.count == correctAnswers.count
            if userAnsweredCorrectly {
                correctAnswers.forEach { answer in
                    if !userAnswer.contains(answer) {
                        userAnsweredCorrectly = false
                    }
                }
            }
            let wrongAnswer = userAnsweredCorrectly ? nil : formattedAnswer(userAnswer)
            return PresantableAnswer(question: value, answer: formattedCorrectAnswer, wrongAnswer: wrongAnswer)
        }
    }
    
    private func formattedAnswer(_ answer: [String], separator: String = ", ") -> String {
        return answer.joined(separator: separator)
    }
}
