//
//  HabitCreateInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 25/01/2024.
//

import Foundation
import Combine

// All variables here
class HabitCreateInteractor {
    private let remote: HabitCreateRemoteDataSource = .shared
}

//Specifying all business logic here
extension HabitCreateInteractor {
    
    func save(habitCreateRequest request: HabitCreateRequest) -> Future<Void, AppError>{
        return remote.save(request: request)
    }
}
