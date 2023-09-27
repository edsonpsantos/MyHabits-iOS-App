//
//  HabitUIState.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 27/09/2023.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList
    case error(String)
}
