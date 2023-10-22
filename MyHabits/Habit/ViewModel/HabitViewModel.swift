//
//  HabitViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 27/09/2023.
//

import Foundation
import SwiftUI
import Combine

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .loading
    @Published var title = ""
    @Published var headline = ""
    @Published var description = ""
    
    private var cancellableRequest:AnyCancellable?
    private let interactor: HabitInteractor
    
    init(interactor: HabitInteractor){
        self.interactor=interactor
    }
    
    deinit {
        cancellableRequest?.cancel()
    }
    
    func onAppear() {
        self.uiState = .emptyList
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                //Here is calling Failure or Finished event
                switch (completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            },
                  receiveValue: {response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = ""
                    self.headline = "Be up to date"
                    self.description = "You still don't have habits !"
                } else {
                    self.uiState = .fullList(
                        response.map {
                            
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Very good"
                            self.headline = "Your habits are updated"
                            self.description = ""
                            
                            if lastDate < Date().toString(destPattern: "dd/MM/yyyy"){
                                state = .red
                                self.title = "Attention"
                                self.headline = "Be up to date"
                                self.description = "Your habits are outdated"
                            }
                            
                            return HabitCardViewModel(id: $0.id,
                                                      icon: $0.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: $0.name,
                                                      label: $0.label,
                                                      value: "\($0.value ?? 0)",
                                                      state: state)
                        }
                    )
                }
            }
        )
    }
}
