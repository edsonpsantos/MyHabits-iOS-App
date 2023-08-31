//
//  WebService.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 30/08/2023.
//

import Foundation

enum WebService{
    
        
    private static func completeUrl(path: LocalEnvironment.Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(LocalEnvironment.Endpoint.baseUrl.rawValue)\(path.rawValue)") else{return nil}
        
                return URLRequest(url: url)
    }
    
    static func postUser(request: SignUpRequest){
        
        guard let jsonData = try? JSONEncoder().encode(request) else { return }
        
        guard var urlRequest = completeUrl(path: .postUser) else{ return }
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest){
            data, response, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            
            print(String(data: data, encoding: .utf8))
            print("Response \n")
            print(response)
            
            if let res = response as? HTTPURLResponse{
                print(res.statusCode)
            }
        }
        task.resume()
    }
}
