//
//  ProfileViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/11/2023.
//

import Foundation


class ProfileViewModel: ObservableObject{
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var mobileValidation = MobileValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
}

class FullNameValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "" {
        didSet{
            failure = value.count < 3
        }
    }
}

class MobileValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "" {
        didSet{
            failure = value.count < 9 || value.count >= 10
        }
    }
}

class BirthdayValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "" {
        didSet{
            failure = value.count != 10
        }
    }
}

