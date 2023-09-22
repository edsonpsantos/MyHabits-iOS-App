//
//  SignInInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 16/09/2023.
//

import Foundation
import Combine

// All variables here
class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared

    private let local: LocalDataSource = .shared
}

//Specifying all business logic here
extension SignInInteractor {
    
    func login(loginRequest: SignInRequest) -> Future<SignInResponse, AppError>{
        return remote.login(loginRequest: loginRequest)
    }
    
    func insertAuth (userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
