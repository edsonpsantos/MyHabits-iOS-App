//
//  EditTextView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 23/08/2023.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var autoCapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack{
            if isSecure{
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            }else{
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocapitalization(autoCapitalization)
                    .textFieldStyle(CustomTextFieldStyle())
                    .onChange(of: text) { value in
                        if let mask = mask {
                            Mask.mask(mask: mask, value: value, text: &text)
                        }
                    }
            }
            if let error = error, failure==true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
    }
}


struct EditTextView_Previews: PreviewProvider{
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self) { colorValue in
            VStack{
                EditTextView(text: .constant("Teste"),
                             placeholder: "E-mail",
                             error:"Campo inválido",
                             failure: "2@2".count<2)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme(colorValue)
        }
    }
}

