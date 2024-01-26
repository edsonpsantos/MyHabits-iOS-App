//
//  ProfileEditTextView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/01/2024.
//

import SwiftUI

struct ProfileEditTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var autoCapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack{
            TextField(placeholder, text: $text)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .autocapitalization(autoCapitalization)
                .onChange(of: text) { value in
                    if let mask = mask {
                        Mask.mask(mask: mask, value: value, text: &text)
                    }
                }
                .multilineTextAlignment(.trailing)
        }
        .padding(.bottom, 10)
    }
}


struct ProfileEditTextView_Previews: PreviewProvider{
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self) { colorValue in
            VStack{
                ProfileEditTextView(text: .constant("Teste"),
                             placeholder: "E-mail")
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme(colorValue)
        }
    }
}

