//
//  CustomTextFieldStyle.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 23/08/2023.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {   
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8.8)
                    .stroke(Color.orange, lineWidth: 0.8)
            )
    }
}
