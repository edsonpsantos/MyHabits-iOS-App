//
//  SplashViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 15/08/2023.
//

import SwiftUI
import Combine

class SplashViewModel:ObservableObject{
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit{
        cancellableAuth?.cancel()
    }
    //Do something async and change the state of the uiState
    func onAppear(){
        let currentDate = Date().timeIntervalSince1970
        
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(3), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if (currentDate > Double(userAuth!.expires)) {
                    //call refreshToken
                    print("Expired token")
                } else {
                    self.uiState = .goToHomeScreen
                }
            }
        
        //Simulates network latency until the backend is ready
        //Wait 3 seconds and then execute something
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.uiState = .goToSignInScreen
        }
    }
}


extension SplashViewModel{
    func signInView() -> some View{
        return SplashViewRouter.makeSigInView()
    }
}

