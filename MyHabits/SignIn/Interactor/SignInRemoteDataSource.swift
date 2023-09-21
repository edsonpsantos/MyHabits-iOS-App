//
//  RemoteDataSource.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 16/09/2023.
//

import Foundation
import Combine

//Singleton pattern
//Have a unique instance [life] object inside the application
class SignInRemoteDataSource {
    
    static var shared: SignInRemoteDataSource = SignInRemoteDataSource()
    
    //avoid creation new instances
    private init(){
    }
    
    func login(loginRequest: SignInRequest) -> Future<SignInResponse, AppError> {
        
        return Future<SignInResponse, AppError>{ promise in
            
            WebService.call(path: .login, params:  [
                URLQueryItem(name: "username", value: loginRequest.email),
                URLQueryItem(name: "password", value: loginRequest.password)
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
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try?decoder.decode(SignInResponse.self, from: data)
                    
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
