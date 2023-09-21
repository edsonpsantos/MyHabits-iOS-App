//
//  SignUpInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 21/09/2023.
//

import Foundation
import Combine

class SignUpInteractor {
    
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    
    // TODO
    //private let local: LocalDataSource
}

extension SignUpInteractor {
    //Using parameter external view(signUpRequest and internal used (request)
    func postUser(signUpRequest request: SignUpRequest) -> Future<Bool, AppError>{
        return remoteSignUp.postUser(signUpRequest: request)
    }
    
    func login(signInRequest request: SignInRequest) -> Future<SignInResponse, AppError>{
        return remoteSignIn.login(loginRequest: request)
    }
}



