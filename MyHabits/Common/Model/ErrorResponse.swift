//
//  ErrorResponse.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 04/09/2023.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey{
        case detail
    }
}
