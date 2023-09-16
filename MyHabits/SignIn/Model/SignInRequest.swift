//
//  SignInRequest.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 06/09/2023.
//

import Foundation

//is not a Encodable struct
//because this code is a pratice to use the properties as a url parameters
struct SignInRequest {
    let email: String
    let password: String
}
