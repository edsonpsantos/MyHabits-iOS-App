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
    
    let interactor: HabitCreateInteractor
    
    init( interactor: HabitCreateInteractor) {
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
        cancellable = interactor.save(habitCreateRequest: HabitCreateRequest(imageData: imageData,
                                name: name,
                                label: label))
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch(completion){
            case .failure(let appError):
                self.uiState = .error(appError.message)
                break
            case .finished:
                break
            }
        }, receiveValue: {
            self.uiState = .success
            self.habitPublisher?.send(true)
        })
    }
}
