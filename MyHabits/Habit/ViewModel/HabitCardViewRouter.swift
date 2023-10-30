//
//  HabitCardViewRouter.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 30/10/2023.
//

import Foundation
import SwiftUI

enum HabitCardViewRouter {
    static func makeHabitDetailView(id: Int, name:String, label: String) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label)
        return HabitDetailView(viewModel: viewModel)
    }
}
