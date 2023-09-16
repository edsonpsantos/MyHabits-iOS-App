//
//  SignInErrorResponse.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 16/09/2023.
//

import Foundation

struct SignInErrorResponse:Decodable {
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey{
        case detail
    }
}


struct SignInDetailErrorResponse: Decodable {
    let message: String
    enum CodinKeys: String, CodingKey{
        case message  
    }
}
