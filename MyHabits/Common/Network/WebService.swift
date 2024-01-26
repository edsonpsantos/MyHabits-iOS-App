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
        case multipart = "multipart/form-data"
    }
    
    private static func completeUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(LocalEndpoint.baseURL.rawValue)\(path)") else{return nil}
        
        return URLRequest(url: url)
    }
    
    
    private static func call(path: String,
                             method: Method,
                             contentType: ContentType,
                             data: Data?,
                             boundary: String = "",
                             completion: @escaping(Result)->Void) {
        
        guard var urlRequest = completeUrl(path: path) else{ return }
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink {  userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                if contentType == .multipart {
                    urlRequest.setValue("multipart/form-data; boundary\(boundary)", forHTTPHeaderField: "Content-Type")
                } else {
                    urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                }
                
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                
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
                        case 201:
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
                            data: Data? = nil,
                            completion: @escaping (Result) -> Void) {
      guard let urlRequest = completeUrl(path: path.rawValue) else { return }
      
      guard let absoluteURL = urlRequest.url?.absoluteString else { return }
      var components = URLComponents(string: absoluteURL)
      components?.queryItems = params
      
      let boundary = "Boundary-\(NSUUID().uuidString)"
      
      call(path: path.rawValue,
           method: method,
           contentType: data != nil ? .multipart : .formURL,
           data: data != nil ? createBodyWithParameters(
            params: params,
            data: data!,
            boundary: boundary)
            : components?.query?.data(using: .utf8),
           boundary: boundary,
           completion: completion)
    }
    
    private static func createBodyWithParameters(params: [URLQueryItem], data: Data, boundary: String) -> Data {
      let body = NSMutableData()
      
      for param in params {
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(param.name)\"\r\n\r\n")
        body.appendString("\(param.value!)\r\n")
      }
      
      let filename = "img.jpg"
      let mimetype = "image/jpeg"
      
      body.appendString("--\(boundary)\r\n")
      body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
      body.appendString("Content-Type: \(mimetype)\r\n\r\n")
      body.append(data)
      body.appendString("\r\n")
      
      body.appendString("--\(boundary)--\r\n")
      
      return body as Data
    }
    
    
  }

  extension NSMutableData {
    func appendString(_ string: String) {
      append(string.data(using: .utf8, allowLossyConversion: true)!)
    }
  }
