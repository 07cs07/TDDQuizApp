//
//  Question.swift
//  QuizEngine
//
//  Created by Mahalingam, Balachander on 25/04/20.
//  Copyright © 2020 Mahalingam, Balachander. All rights reserved.
//

import Foundation

public enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    public var hashValue: Int {
        
        switch self {
        case .singleAnswer(let value):
            return value.hashValue
        case .multipleAnswer(let value):
            return value.hashValue
        }
    }
}
