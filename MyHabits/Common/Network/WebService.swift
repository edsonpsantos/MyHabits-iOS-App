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
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.baseURL.rawValue)\(path.rawValue)") else{return nil}
        
                return URLRequest(url: url)
    }
    
    private static func call<T: Encodable>(path: Endpoint,
                                           body: T,
                                           completion: @escaping (Result)-> Void){
        
        guard var urlRequest = completeUrl(path: path) else{ return }
        
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
                
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
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
    
    static func postUser(request: SignUpRequest, completion: @escaping(Bool?, ErrorResponse?)->Void){
        call(path: .postUser, body: request, completion: {
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
}
