//
//  HomeViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 16/08/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
}

extension HomeViewModel {
    func habitView() -> some View{
        return HomeViewRouter.makeHabitView()
    }
}
