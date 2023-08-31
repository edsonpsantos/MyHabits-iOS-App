//
//  SignInViewRouter.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 15/08/2023.
//

import SwiftUI

enum SplashViewRouter{
    
    static func makeSigInView() -> some View{
        let viewModel = SignInViewModel()
        
        return SignInView(viewModel: viewModel)
    }
}
