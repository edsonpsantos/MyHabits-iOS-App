//
//  GenderSelectorView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/11/2023.
//

import SwiftUI

struct GenderSelectorView: View {
    
    @Binding var selectedGender: Gender?
    let title: String
    let genders: [Gender]
    
    
    var body: some View {
        Form{
            Section(header: Text(title)) {
                List(genders, id: \.id){ item in
                    HStack{
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(
                                selectedGender == item ?  .orange : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == item){
                            selectedGender = item
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

#Preview {
    GenderSelectorView(selectedGender: .constant(.male), title: "Teste", genders: Gender.allCases)
}
