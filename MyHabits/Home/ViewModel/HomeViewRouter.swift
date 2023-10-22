//
//  HomeViewRouter.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 27/09/2023.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView() -> some View {
        let viewModel =  HabitViewModel(interactor: HabitInteractor())
        
        return HabitView(viewModel: viewModel)
    }
}

