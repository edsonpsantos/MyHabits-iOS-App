//
//  HabitCreateRequest.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 25/01/2024.
//

import Foundation

//struct no Encodable ou Decodable, because will not be used Json, like SignInRequest

struct HabitCreateRequest {
    
    let imageData: Data?
    let name: String
    let label: String
}
