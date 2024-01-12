//
//  ChartViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 08/01/2024.
//

import Foundation
import SwiftUI
import Charts
import Combine

class ChartViewModel: ObservableObject{
    
    @Published var uiSate = ChartUiState.loading
    @Published var entries:[ChartDataEntry] = []
    @Published var dates: [String] = []
    
    private var cancellabe: AnyCancellable?
    
    private let habitId: Int
    private let interactor: ChartInteractor
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    deinit {
        cancellabe?.cancel()
    }
    
    func onAppear(){
        cancellabe = interactor.fetchHabitValues(habitId: habitId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                case .failure(let appError):
                    self.uiSate = .error(appError.message)
                case .finished:
                    break
                }
            }, receiveValue: {response in
                    print(response)
            })
    }
    
}
