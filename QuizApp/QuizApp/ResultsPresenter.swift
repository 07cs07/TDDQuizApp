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
        let formattedUserAnswer = formattedAnswer(userAnswer)
        let formattedCorrectAnswer = formattedAnswer(correctAnswers)
        switch question {
        case .singleAnswer(let value):
            let wrongAnswer = formattedCorrectAnswer == formattedUserAnswer ? nil : formattedUserAnswer
            return PresantableAnswer(question: value, answer: formattedCorrectAnswer, wrongAnswer: wrongAnswer)
            
        case .multipleAnswer(let value):
            var userAnsweredCorrectly = true
            userAnswer.forEach { answer in
                if !correctAnswers.contains(answer) {
                    userAnsweredCorrectly = false
                }
            }
            let wrongAnswer = userAnsweredCorrectly ? nil : formattedUserAnswer
            return PresantableAnswer(question: value, answer: formattedCorrectAnswer, wrongAnswer: wrongAnswer)
        }
    }
    
    private func formattedAnswer(_ answer: [String]) -> String {
        return answer.joined(separator: ", ")
    }
}
