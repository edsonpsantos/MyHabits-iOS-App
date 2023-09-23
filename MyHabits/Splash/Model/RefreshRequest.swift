//
//  RefreshRequest.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 23/09/2023.
//

import Foundation

struct RefreshRequest: Encodable {

    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
