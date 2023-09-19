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
    
    private let remote: RemoteDataSource = .shared
    
    // TODO
    //private let local: LocalDataSource
}

//Specifying all business logic here
extension SignInInteractor {
    
    func login(loginRequest: SignInRequest) -> Future<SignInResponse, AppError>{
        return remote.login(loginRequest: loginRequest)
    }
}
