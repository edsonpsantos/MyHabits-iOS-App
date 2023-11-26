//
//  MyHabitsApp.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 14/08/2023.
//

import SwiftUI

@main
struct MyHabitsApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: 
                        SplashViewModel(interactor: SplashInteractor())
            )
        }
    }
}
