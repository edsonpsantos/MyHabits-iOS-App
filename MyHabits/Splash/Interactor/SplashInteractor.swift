//
//  SplashInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 22/09/2023.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    
    func fetchAuth() -> Future<UserAuth?, Never> {
        return  local.getUserAuth()
    }
    
    func insertUserAuth(userAuth: UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return remote.refreshToken(request: request)
    }
}
