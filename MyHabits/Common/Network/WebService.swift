//
//  WebService.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 30/08/2023.
//

import Foundation

enum WebService{
    
    enum NetworkError{
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formURL = "application/x-www-form-urlencoded"
    }
    
    private static func completeUrl(path: LocalEndpoint) -> URLRequest? {
        guard let url = URL(string: "\(LocalEndpoint.baseURL.rawValue)\(path.rawValue)") else{return nil}
        
        return URLRequest(url: url)
    }
    
    
    private static func call(path:LocalEndpoint, contentType: ContentType, data: Data?, completion: @escaping(Result)->Void) {
        
        guard var urlRequest = completeUrl(path: path) else{ return }
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        
        //Background running (Non-Main Thread
        let task = URLSession.shared.dataTask(with: urlRequest){
            data, response, error in
            guard let data = data, error == nil else {
                print(error as Any)
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let res = response as? HTTPURLResponse{
                switch res.statusCode {
                case 200:
                    completion(.success(data))
                    break
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                case 401:
                    completion(.failure(.unauthorized, data))
                    break
                default:
                    break
                }
            }
            print(String(data: data, encoding: .utf8) as Any)
            print("Response \n")
            print(response as Any)
        }
        task.resume()
    }
    
    private static func call<T: Encodable>(path: LocalEndpoint,
                                           body: T,
                                           completion: @escaping (Result)-> Void){
        
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        call(path: path, contentType: .json, data: jsonData, completion: completion)
    }
    
    private static func call(path: LocalEndpoint,
                             params: [URLQueryItem],
                             completion: @escaping (Result)-> Void){
        
        guard let urlRequest = completeUrl(path: path) else {return}
        guard let absoluteURL = urlRequest.url?.absoluteString else {return}
        
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        call(path: path, contentType: .formURL, data: components?.query?.data(using: .utf8), completion: completion)
    }
    
    static func postUser(signUpRequest: SignUpRequest, completion: @escaping(Bool?, ErrorResponse?)->Void){
        call(path: .postUser, body: signUpRequest, completion: {
            result in
            switch result {
            case .failure(let error, let data):
                if let data = data {
                    if error == .badRequest{
                        let decoder = JSONDecoder()
                        let response = try?decoder.decode(ErrorResponse.self, from: data)
                        completion(nil, response)
                    }
                }
                break
            case .success(let data):
                completion(true,nil)
                break
            }
        })
    }
    
    static func login(loginRequest: SignInRequest, completion: @escaping(SignInResponse?, ErrorResponse?)->Void){
        call(path: .login, params:  [
            URLQueryItem(name: "username", value: loginRequest.email),
            URLQueryItem(name: "password", value: loginRequest.password)
        ], completion: {
            result in
            switch result {
            case .failure(let error, let data):
                if let data = data {
                    if error == .unauthorized{
                        let decoder = JSONDecoder()
                        let response = try?decoder.decode(ErrorResponse.self, from: data)
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
        })
    }
}
