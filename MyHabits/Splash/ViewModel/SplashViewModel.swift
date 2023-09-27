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
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit{
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
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
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion){
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            
                            let userAuth = UserAuth(idToken: success.accessToken,
                                                    refreshToken: success.refreshToken,
                                                    expires: Date().timeIntervalSince1970 + success.expires ,
                                                    tokenType: success.tokenType)
                            
                            self.interactor.insertUserAuth(userAuth: userAuth )
                            self.uiState = .goToHomeScreen
                            
                        })
                } else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
}


//Routes
extension SplashViewModel{
    func signInView() -> some View{
        return SplashViewRouter.makeSigInView()
    }
    
    func homeView() -> some View{
        return SplashViewRouter.makeHomeView()
    }
}

