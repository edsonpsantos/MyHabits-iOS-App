//
//  HabitRemoteDataSource.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 22/10/2023.
//

import Foundation
import Combine

//Singleton pattern
//Have a unique instance [life] object inside the application
class HabitRemoteDataSource {
    
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    //avoid creation new instances
    private init(){
    }
    
    func fetchHabits() -> Future<[HabitResponse],AppError> {
        
        return Future<[HabitResponse], AppError>{ promise in
            
            WebService.call(path: .habits, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try?decoder.decode(SignInErrorResponse.self, from: data)
                        
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Unknown server error")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try?decoder.decode([HabitResponse].self, from: data)
                    
                    guard let response = response else {
                        print("Log.: Parse error \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(response))
                    
                    break
                }
            }
        }
    }
}
