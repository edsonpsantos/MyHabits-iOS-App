//
//  SignUpRequest.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 31/08/2023.
//

import Foundation

struct SignUpRequest: Encodable {

    let fullName: String
    let email: String
    let password: String
    let document: String
    let phoneNumber: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case password
        case document
        case phoneNumber = "phone"
        case birthday
        case gender
    }
}
