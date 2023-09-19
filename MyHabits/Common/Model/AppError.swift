//
//  AppError.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 19/09/2023.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self  {
        case .response(let message):
            return message
        }
    }
}
