//
//  SignUpViewRouter.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 18/08/2023.
//

import SwiftUI

enum SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
