//
//  HabitView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 27/09/2023.
//

import Foundation
import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel = HabitViewModel()
    
    var body: some View{
        ZStack {
            if case HabitUIState.loading=viewModel.uiState{
                progress
            } else if case HabitUIState.emptyList = viewModel.uiState{
                
            }
            else if case HabitUIState.fullList = viewModel.uiState{
                
            }
            else if case HabitUIState.error = viewModel.uiState{
                
            }
        }
    }
}


extension HabitView{
    var progress: some View{
        ProgressView()
    }
}


struct HabitView_Previews: PreviewProvider{
    static var previews: some View{
        HomeViewRouter.makeHabitView()
    }
}
