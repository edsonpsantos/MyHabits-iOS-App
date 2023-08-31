//
//  SignUpState.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 18/08/2023.
//

import Foundation

enum SignUpUIState:Equatable {
    case none
    case loading
    case success
    case error(String)
}
