//
//  ProfileRequest.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 04/01/2024.
//

import Foundation

struct ProfileRequest: Encodable {

    let fullName: String
    let phoneNumber: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case phoneNumber = "phone"
        case birthday
        case gender
    }
}
