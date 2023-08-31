//
//  SplashViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 15/08/2023.
//

import SwiftUI

class SplashViewModel:ObservableObject{
    @Published var uiState: SplashUIState = .loading
    
    //Faz algo async e altera o estado da uiState
    func onAppear(){
        //Simula latencia de rede até o backend estiver pronto
        //Aguarda 3 segundos e depois executa algo
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

