//
//  HabitDetailUIState.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 25/10/2023.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
