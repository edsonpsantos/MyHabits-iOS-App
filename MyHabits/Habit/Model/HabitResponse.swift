//
//  HabitResponse.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 22/10/2023.
//

import Foundation

struct HabitResponse: Decodable {
    let id: Int
        let name: String
        let label: String
        let iconUrl: String?
        let value: Int?
        let lastDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconUrl = "icon_url"
        case label
        case value
        case lastDate = "last_date"
    }
}
