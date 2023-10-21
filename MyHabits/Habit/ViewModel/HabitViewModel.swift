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
    
    func onAppear(){
        self.uiState = .emptyList
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            var rows:[HabitCardViewModel] = []
            
            rows.append(HabitCardViewModel(id: 1,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2023",
                                           name: "Play Drums",
                                           label: "Hours",
                                           value: "1",
                                           state: .red))
            
            rows.append(HabitCardViewModel(id: 2,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2023",
                                           name: "Pstudy Swift",
                                           label: "Hours",
                                           value: "4",
                                           state: .green))
            
            rows.append(HabitCardViewModel(id: 3,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2023",
                                           name: "Drink water",
                                           label: "glasses",
                                           value: "2",
                                           state: .yellow))
               
            rows.append(HabitCardViewModel(id: 4,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2023",
                                           name: "Drink water",
                                           label: "glasses",
                                           value: "2",
                                           state: .blue))
               
            rows.append(HabitCardViewModel(id: 5,
                                           icon: "https://placehold.co/150x150",
                                           date: "01/01/2023",
                                           name: "Drink water",
                                           label: "glasses",
                                           value: "2",
                                           state: .blue))
            
            //self.uiState = .fullList(rows)
            self.uiState = .error("Internal Server Error")
            
        }
    }
}
