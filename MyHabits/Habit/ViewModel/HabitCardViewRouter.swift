//
//  HabitCardViewRouter.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 30/10/2023.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter {
    static func makeHabitDetailView(id: Int, name:String, label: String, habitPublisher: PassthroughSubject<Bool,Never>) -> some View {
        
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor:  HabitDetailInteractor())
        
        viewModel.habitPublisher = habitPublisher
        
        return HabitDetailView(viewModel: viewModel)
    }
}
