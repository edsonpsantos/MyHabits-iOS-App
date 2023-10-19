//
//  HabitViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 27/09/2023.
//

import Foundation

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .emptyList
    @Published var title = "Attention"
    @Published var headline = "Be up to date"
    @Published var description = "Your habits are outdated"
}
