//
//  Game.swift
//  QuizEngine
//
//  Created by Mahalingam, Balachander on 11/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation

public struct Game<R: Router> {
    let flow: Flow<R>
    init(flow: Flow<R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer, R: Router>(questions: [Question], router: R, correctAnswers:[Question: Answer]) -> Game<R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router) { scoring($0, correctAnswers: correctAnswers)}
    flow.start()
    return Game(flow: flow)
}

private func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], correctAnswers:  [Question: Answer]) -> Int {
    return answers.reduce(0) { (score, tuple) -> Int in
        var userAnsweredCorrectly = true
        if let userAnswer = tuple.value as? [String], let correctAnswers = correctAnswers[tuple.key] as? [String] {
            userAnsweredCorrectly = userAnswer.count == correctAnswers.count
            
            if userAnsweredCorrectly {
                correctAnswers.forEach { answer in
                    if !userAnswer.contains(answer) {
                        userAnsweredCorrectly = false
                    }
                }
            }
        }
        
        return score + (userAnsweredCorrectly ? 1 : 0)
    }
}
