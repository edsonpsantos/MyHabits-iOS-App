//
//  HabitDetailInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 30/10/2023.
//

import Foundation

import Combine

// All variables here
class HabitDetailInteractor {
    
    private let remote: HabitDetailRemoteDataSource = .shared

}

//Specifying all business logic here
extension HabitDetailInteractor {
    
    func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppError>{
        return remote.save(habitId:habitId, request: request)
    }
}
