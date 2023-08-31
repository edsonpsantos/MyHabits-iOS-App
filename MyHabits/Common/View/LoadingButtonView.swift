//
//  LoadingButtonView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 24/08/2023.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var text: String
    var disabled: Bool = false
    var showProgressBar: Bool = false
    
    var body: some View {
        ZStack{
            Button(action: {
                action()
                
            },label:{
                Text(showProgressBar ? "" : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(.system(.title3).bold())
                    .background(disabled ? Color("ligthOrange") : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4.0)
            }).disabled(disabled || showProgressBar)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgressBar ? 1 : 0)
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorValue in
            VStack{
                LoadingButtonView(action: {
                    print("Ola Mundo!")
                }, text: "Log In",
                  disabled: false,
                  showProgressBar: false)
            }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme(colorValue)
        }
        
    }
}
