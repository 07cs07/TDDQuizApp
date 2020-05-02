//
//  Flow.swift
//  QuizEngine
//
//  Created by Mahalingam, Balachander on 02/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation

class Flow<R: Router> {
    private let router: R
    private let questions: [R.Question]
    private var answers: [R.Question: R.Answer] = [:]
    private var scoring: (([R.Question: R.Answer]) -> Int)
    
    init(questions: [R.Question], router: R, scoring: @escaping (([R.Question: R.Answer]) -> Int)) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            router.routeTo(result: result())
        }
    }
    
    private func routeNext(from currentQuestion: R.Question) -> R.AnswerHandler {
        return { answer in
            self.answers[currentQuestion] = answer
            if let currentQuestionIndex = self.questions.firstIndex(of: currentQuestion), currentQuestionIndex + 1 < self.questions.count {
                let nextQuestion = self.questions[currentQuestionIndex + 1]
                self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
            } else {
                self.router.routeTo(result: self.result())
            }
        }
    }
    
    private func result() -> Result<R.Question, R.Answer> {
        return Result(score: scoring(answers), answers: answers)
    }
}
