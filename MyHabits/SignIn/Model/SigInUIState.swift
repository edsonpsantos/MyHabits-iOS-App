//
//  SiginUIState.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 16/08/2023.
//

import Foundation

enum SigInUIState: Equatable{
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
