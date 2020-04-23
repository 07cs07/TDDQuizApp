//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Mahalingam, Balachander on 23/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let currentQuestion: Question<String>
    
    var title: String {
        guard let index = questions.firstIndex(of: currentQuestion) else { return "" }
        return "Question #\(index + 1)"
    }
}
