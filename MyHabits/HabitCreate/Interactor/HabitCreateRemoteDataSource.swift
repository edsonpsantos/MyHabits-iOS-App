//
//  HabitCreateRemoteDataSource.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 25/01/2024.
//

import Foundation

import Combine

//Singleton pattern
//Have a unique instance [life] object inside the application
class HabitCreateRemoteDataSource {
    
    static var shared: HabitCreateRemoteDataSource = HabitCreateRemoteDataSource()
   
    //avoid creation new instances
    private init(){
    }
    
    func save(request: HabitCreateRequest) -> Future<Void, AppError> {
        
        return Future<Void, AppError>{ promise in
            
            WebService.call(path: .habits, params:  [
                URLQueryItem(name: "name", value: request.name),
                URLQueryItem(name: "label", value: request.label)
            ]) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized{
                            let decoder = JSONDecoder()
                            let response = try?decoder.decode(SignInErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Unknown server error")))
                        }
                    }
                    break
                case .success(_):
                    
                    promise(.success(()))
                    
                    break
                }
            }
        }
    }
}
