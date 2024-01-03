//
//  ProfileRemoteDataSource.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 03/01/2024.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    //avoid creation new instances
    private init(){
    }
    
    func fetchUser() -> Future<ProfileResponse, AppError>{
        return Future { promise in
            WebService.call(path: .fetchUser, method: .get)
            { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try?decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Unknown server error")))
                    }
                    break
                case .success(let data):
                  let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(res))
                    break
                }
            }
        }
    }
    
}
