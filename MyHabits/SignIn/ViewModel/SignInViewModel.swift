//
//  SignInViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 15/08/2023.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject{
    
    private var cancellable: AnyCancellable?
    private let publisher = PassthroughSubject<Bool,Never>()
    
    @Published var email = ""
    @Published var password = ""
   
    @Published var uiState: SigInUIState = .none
    
    init(){
        cancellable = publisher.sink{ value in
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func login(){
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            //self.uiState = .error("Usuário ou senha invalidos.")
            self.uiState = .goToHomeScreen
        }
        
    }
    
}

extension SignInViewModel {
    func homeView() -> some View{
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
