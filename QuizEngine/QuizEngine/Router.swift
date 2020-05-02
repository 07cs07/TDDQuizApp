//
//  Router.swift
//  QuizEngine
//
//  Created by Mahalingam, Balachander on 11/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer: Equatable
    
    typealias AnswerHandler = ((Answer) -> Void)
    func routeTo(question: Question, answerCallback: @escaping ((Answer) -> Void))
    func routeTo(result: Result<Question, Answer>)
}
