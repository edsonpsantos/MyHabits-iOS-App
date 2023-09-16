//
//  RemoteDataSource.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 16/09/2023.
//

import Foundation

//Singleton pattern
//Have a unique instance [life] object inside the application
class RemoteDataSource {
    
    static var shared: RemoteDataSource = RemoteDataSource()
    
    //avoid creation new instances
    private init(){
    }
    
    func login(loginRequest: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?)-> Void){
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
                        completion(nil, response)
                    }
                }
                break
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try?decoder.decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
            }
        }
    }
}
