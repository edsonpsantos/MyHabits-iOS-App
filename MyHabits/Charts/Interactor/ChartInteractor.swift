//
//  ChartInteractor.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 12/01/2024.
//

import Foundation
import Combine

class ChartInteractor {
    private let remote: ChartRemoteDataSource = .shared
}

extension ChartInteractor {
    //Using parameter external view(signUpRequest and internal used (request)
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError>{
        return remote.fetchHabitValues(habitId: habitId)
    }
}



