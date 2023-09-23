//
//  SplashRemoteDataSource.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 23/09/2023.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    
    //Singleton Pattern
    
    static var shared: SplashRemoteDataSource = SplashRemoteDataSource()
    
    private init(){
    }
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse,AppError> { promise in
            WebService.call(path: .refreshToken,method: .put, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Unknown server error")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
                    
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
