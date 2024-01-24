//
//  HabitCreateViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 15/01/2024.
//

import Foundation
import Combine
import SwiftUI

class HabitCreateViewModel: ObservableObject {
    @Published var uiState: HabitDetailUIState = .none
    @Published var name = ""
    @Published var label = ""
    
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = nil
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    let interactor: HabitDetailInteractor
    
    init( interactor: HabitDetailInteractor) {
        self.interactor = interactor
    }
    
    deinit{
        cancellable?.cancel()
        for cancellabe in cancellables{
            cancellabe.cancel()
        }
    }
    
    func save(){
        self.uiState = .loading
    }
}
