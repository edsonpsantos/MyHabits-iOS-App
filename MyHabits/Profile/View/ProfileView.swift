//
//  ProfilrView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/11/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var fullName = ""
    @State var email = "teste@gmail.com"
    @State var fiscalDocument = "123.456.789-99"
    @State var phoneNumber = "996 654 321"
    @State var birthDay = "01/01/1990"
    
    @State var selectedGender: Gender? = .male
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Registration Data")) {
                        HStack{
                            Text("Name: ")
                            Spacer()
                            TextField("Inform your name", text: $fullName)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text("E-mail: ")
                            Spacer()
                            TextField("", text: $email)
                                .disabled(true)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text("Fiscal Document: ")
                            Spacer()
                            TextField("", text: $fiscalDocument)
                                .disabled(true)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text("Mobile: ")
                            Spacer()
                            TextField("Inform your phone number", text: $phoneNumber)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack{
                            Text("Birth Day: ")
                            Spacer()
                            TextField("Inform your BirthDay", text: $birthDay)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        NavigationLink(
                            destination: GenderSelectorView(
                                selectedGender: $selectedGender,
                                title: "Select gender",
                                genders: Gender.allCases),
                            label: {
                                HStack{
                                    Text("Gender")
                                    Spacer()
                                    Text(selectedGender?.rawValue ?? "")
                                }
                            }
                        )
                    }
                }
            }
            .navigationBarTitle(Text("Profile Edit"), displayMode: .automatic)
        }
    }
}

#Preview {
    ProfileView()
}
