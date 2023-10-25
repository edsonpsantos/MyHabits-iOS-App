//
//  HomeViewRouter.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 27/09/2023.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
}

