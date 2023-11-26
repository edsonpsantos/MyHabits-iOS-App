//
//  HabitDetailRemoteDataSource.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 30/10/2023.
//

import Foundation

import Combine

class HabitDetailRemoteDataSource {
    
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    //avoid creation new instances
    private init(){
    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        
        return Future<Bool, AppError>{ promise in
            let path = String(format: LocalEndpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .post, body: request) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try?decoder.decode(SignInErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Unknown server error")))
                    }
                    break
                case .success(_):
                    promise(.success(true))
                    break
                }
            }
        }
    }
}

