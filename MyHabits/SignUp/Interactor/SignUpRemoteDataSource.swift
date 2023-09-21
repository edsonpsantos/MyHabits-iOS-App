//
//  SignUpRemoteDataSource.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 21/09/2023.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    //avoid creation new instances
    private init(){
    }
    
    func postUser(signUpRequest: SignUpRequest) -> Future<Bool, AppError>{
        return Future { promise in
            WebService.call(path: .postUser, body: signUpRequest)
            { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .badRequest{
                            let decoder = JSONDecoder()
                            let response = try?decoder.decode(ErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail ?? "Unknown server error")))
                        }
                    }
                    break
                case .success(_): // This variable is not used in this code scope/block
                    promise(.success(true))
                    break
                }
            }
        }
    }
    
}
