//
//  ProfilrView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/11/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
  @State var email = "teste9999@teste.com"
    @State var fiscalDocument = "123.456.789-99"
    @State var phoneNumber = "996 654 321"
    @State var birthDay = "01/01/1990"
    
    @State var selectedGender: Gender? = .none
    
        
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Registration Data")) {
                        HStack{
                            Text("Full Name: ")
                            Spacer()
                            TextField("Your name here", text: $viewModel.fullNameValidation.value )
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
                        }
                        if(viewModel.fullNameValidation.failure){
                            Text("FullName must be longer than 3 chars").foregroundColor(.red)
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
                            TextField("Your phone number here", text: $viewModel.mobileValidation.value)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        if(viewModel.mobileValidation.failure){
                            Text("Invalid mobile number format")
                                .foregroundColor(.red)
                        }
                        
                        HStack{
                            Text("Birth Day: ")
                            Spacer()
                            TextField("Inform your BirthDay here", text: $viewModel.birthdayValidation.value)
                                .multilineTextAlignment(.trailing)
                        }
                        if(viewModel.birthdayValidation.failure){
                            Text("Invalid date format").foregroundColor(.red)
                        }
                        
                        NavigationLink(
                            destination: GenderSelectorView(
                                selectedGender: $selectedGender,
                                title: "Select gender",
                                genders: Gender.allCases),
                            label: {
                                HStack{
                                    Text("Gender:")
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
    ProfileView(viewModel: ProfileViewModel())
}
