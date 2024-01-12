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
    
    enum Method: String {
        case get
        case post
        case put
        case delete
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formURL = "application/x-www-form-urlencoded"
    }
    
    private static func completeUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(LocalEndpoint.baseURL.rawValue)\(path)") else{return nil}
        
        return URLRequest(url: url)
    }
    
    
    private static func call(path: String,
                             method: Method,
                             contentType: ContentType,
                             data: Data?,
                             completion: @escaping(Result)->Void) {
        
        guard var urlRequest = completeUrl(path: path) else{ return }
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink {  userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                urlRequest.httpMethod = method.rawValue
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
    }
    
    public static func call(path: LocalEndpoint,
                            method: Method = .get,
                            completion: @escaping (Result)-> Void){
        call(path: path.rawValue,
             method: method,
             contentType: .json,
             data: nil,
             completion: completion)
    }
    
    
    public static func call<T: Encodable>(path: LocalEndpoint,
                                          method: Method = .get,
                                          body: T,
                                          completion: @escaping (Result)-> Void){
        
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        call(path: path.rawValue,
             method: method,
             contentType: .json,
             data: jsonData,
             completion: completion)
    }
    public static func call<T: Encodable>(path: String,
                                          method: Method = .get,
                                          body: T,
                                          completion: @escaping (Result)-> Void){
        
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        call(path: path,
             method: method,
             contentType: .json,
             data: jsonData,
             completion: completion)
    }
    
    public static func call(path: String,
                            method: Method = .get,
                            completion: @escaping (Result)-> Void){
        
        call(path: path,
             method: method,
             contentType: .json,
             data: nil,
             completion: completion)
    }
        
    public static func call(path: LocalEndpoint,
                            method: Method = .post,
                            params: [URLQueryItem],
                            completion: @escaping (Result)-> Void){
        
        guard let urlRequest = completeUrl(path: path.rawValue) else {return}
        guard let absoluteURL = urlRequest.url?.absoluteString else {return}
        
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        call(path: path.rawValue, method: method, contentType: .formURL, data: components?.query?.data(using: .utf8), completion: completion)
    }
}
 
