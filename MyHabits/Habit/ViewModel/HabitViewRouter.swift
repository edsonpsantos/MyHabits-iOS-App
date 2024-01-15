//
//  HabitViewRouter.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 15/01/2024.
//

import Foundation
import SwiftUI
import Combine

enum HabitViewRouter {
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool,Never>) -> some View {
        
        let viewModel = HabitCreateViewModel(interactor:  HabitDetailInteractor())
        
        viewModel.habitPublisher = habitPublisher
        
        return HabitCreateView(viewModel: viewModel)
    }
}
