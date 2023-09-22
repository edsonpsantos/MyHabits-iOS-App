//
//  SplashInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 22/09/2023.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    
    func fetchAuth() -> Future<UserAuth?, Never> {
        return  local.getUserAuth()
    }
}
