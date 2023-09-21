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
    
    public static func call<T: Encodable>(path: LocalEndpoint,
                                           body: T,
                                           completion: @escaping (Result)-> Void){
        
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        call(path: path, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: LocalEndpoint,
                             params: [URLQueryItem],
                             completion: @escaping (Result)-> Void){
        
        guard let urlRequest = completeUrl(path: path) else {return}
        guard let absoluteURL = urlRequest.url?.absoluteString else {return}
        
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        call(path: path, contentType: .formURL, data: components?.query?.data(using: .utf8), completion: completion)
    }
}
