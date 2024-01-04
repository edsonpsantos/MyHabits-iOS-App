//
//  ProfileUIState.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 03/01/2024.
//

import Foundation

enum ProfileUIState: Equatable{
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
