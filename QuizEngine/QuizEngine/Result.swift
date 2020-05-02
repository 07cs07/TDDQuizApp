//
//  Result.swift
//  QuizEngine
//
//  Created by Mahalingam, Balachander on 11/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let score: Int
    public let answers: [Question: Answer]
}

// Unit testing private variables and methods
// https://stackoverflow.com/a/60267724
// in my case here, need a public initialiser for the QuizAppTest

#if TESTING
public extension Result {
    
    public init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
#endif



