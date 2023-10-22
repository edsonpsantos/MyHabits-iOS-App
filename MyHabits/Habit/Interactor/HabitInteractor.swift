//
//  HabitInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 22/10/2023.
//

import Foundation
import Combine

// All variables here
class HabitInteractor {
    
    private let remote: HabitRemoteDataSource = .shared

}

//Specifying all business logic here
extension HabitInteractor {
    
    func fetchHabits() -> Future<[HabitResponse], AppError>{
        return remote.fetchHabits()
    }
    
}
