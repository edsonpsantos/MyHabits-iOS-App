//
//  ButtonStyle.swift
//  MyHabits
// Style pattern using modifiers
//  Created by EDSON SANTOS on 21/10/2023.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier{
    
    func body(content: Content) -> some View {
       content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(4.0)
    }
}

