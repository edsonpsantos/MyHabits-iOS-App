//
//  UserAuth.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 22/09/2023.
//

import Foundation

//encapsulates both the Encodable and Decodable protocols
struct UserAuth: Codable {
    
    var idToken:String
    var refreshToken: String
    var expires: Int = 0
    var tokenType: String
    
    enum CodingKeys: String, CodingKey{
        case idToken = "access_token"
        case refreshToken = " refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
