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
    
    private static func completeUrl(path: LocalEnvironment) -> URLRequest? {
        guard let url = URL(string: "\(LocalEnvironment.baseUrl.rawValue)\(path.rawValue)") else{return nil}
        
                return URLRequest(url: url)
    }
    
    private static func call<T: Encodable>(path: LocalEnvironment,
                                           body: T,
                                           completion: @escaping (Result)-> Void){
        
        guard var urlRequest = completeUrl(path: path) else{ return }
        
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
                
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
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
                default:
                    break
                }
            }
            
            
            print("Response \n")
            print(response as Any)
            
           
        }
        task.resume()
    }
    
    static func postUser(request: SignUpRequest){
        call(path: .postUser, body: request, completion: {
            result in
            switch result {
            case .failure(let error, let data):
                if let data = data {
                    print(String(data: data, encoding: .utf8) as Any)
                }
                break
            case .success(let data):
                print(String(data: data, encoding: .utf8) as Any)
                break
            }
        })
    }
}
