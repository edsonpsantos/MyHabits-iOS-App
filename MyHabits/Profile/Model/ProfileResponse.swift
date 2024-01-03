//
//  ProfileResponse.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 03/01/2024.
//

import Foundation
struct ProfileResponse: Decodable {

    let id: Int
    let fullName: String
    let email: String
    let document: String
    let phoneNumber: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "name"
        case email
        case document
        case phoneNumber = "phone"
        case birthday
        case gender
    }
}
