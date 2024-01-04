//
//  ProfileInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 03/01/2024.
//

import Foundation
import Combine

class ProfileInteractor {
    private let remote: ProfileRemoteDataSource = .shared
}

extension ProfileInteractor {
    //Using parameter external view(signUpRequest and internal used (request)
    func fetchUser() -> Future<ProfileResponse, AppError>{
        return remote.fetchUser()
    }
    func updateUser(userId: Int, profileRequest: ProfileRequest)-> Future<ProfileResponse,AppError>{
        return remote.updateUser(userId: userId, request: profileRequest)
    }
    
}



