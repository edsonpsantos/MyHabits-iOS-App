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
    private var cancellableRequest: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool,Never>()
    private let interactor: SignInInteractor
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var uiState: SignInUIState = .none
    
    //Interactor - Dependeny Injected
    init(interactor: SignInInteractor){
        self.interactor = interactor
        cancellable = publisher.sink{ value in
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit{
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login(){
        self.uiState = .loading
        
        cancellableRequest = interactor.login(loginRequest: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                //Here is calling Failure or Finished event
                switch (completion) {
                case .failure(let appError):
                    self.uiState = SignInUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { success in
                // Here is calling Success event
                let auth = UserAuth(idToken: success.accessToken,
                                    refreshToken: success.refreshToken,
                                    expires: Date().timeIntervalSince1970 + success.expires,
                                    tokenType: success.tokenType)
                
                self.interactor.insertAuth(userAuth: auth)
                
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


/* Removed for Swift more reactive with Combine
 interactor.login(loginRequest: SignInRequest(email: email, password: password)) {(successResponse, errorResponse) in
    if let error = errorResponse {
        //Main Thread
        DispatchQueue.main.async {
            self.uiState = .error(error.detail.message)
        }
    }
    
    if let success = successResponse {
        DispatchQueue.main.async {
            print(success)
            self.uiState = .goToHomeScreen
        }
    }
}*/
