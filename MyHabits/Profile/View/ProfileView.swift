//
//  ProfilrView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/11/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool{
        viewModel.fullNameValidation.failure ||
        viewModel.phoneNumberValidation.failure ||
        viewModel.birthdayValidation.failure
    }
    
    @State var selectedGender: Gender? = .none
    
    
    var body: some View {
        ZStack{
            
            if case ProfileUIState.loading = viewModel.uiState{
                ProgressView()
            } else {
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
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack{
                                    Text("Fiscal Document: ")
                                    Spacer()
                                    TextField("", text: $viewModel.fiscalDocument)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack{
                                    Text("Mobile: ")
                                    Spacer()
                                    ProfileEditTextView(text: $viewModel.phoneNumberValidation.value,
                                                 placeholder: "Your mobile number",
                                                 mask:"### ### ###",
                                                 keyboard: .numberPad)
                                    
                                    //TextField("Your phone number here", text: $viewModel.phoneNumberValidation.value)
                                    //    .keyboardType(.numberPad)
                                    //    .multilineTextAlignment(.trailing)
                                }
                                if(viewModel.phoneNumberValidation.failure){
                                    Text("Invalid mobile number format")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("Birth Day: ")
                                    Spacer()

                                    ProfileEditTextView(text: $viewModel.birthdayValidation.value,
                                                 placeholder: "Inform your BirthDay here",
                                                 mask:"##/##/####",
                                                 keyboard: .numberPad)
                                                                        
                                    //TextField("Inform your BirthDay here", text: $viewModel.birthdayValidation.value)
                                   //     .multilineTextAlignment(.trailing)
                                }
                                if(viewModel.birthdayValidation.failure){
                                    Text("Invalid date format").foregroundColor(.red)
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(
                                        selectedGender: $viewModel.gender,
                                        title: "Select gender",
                                        genders: Gender.allCases),
                                    label: {
                                        HStack{
                                            Text("Gender:")
                                            Spacer()
                                            Text(viewModel.gender?.rawValue ?? "")
                                        }
                                    }
                                )
                            }
                        }
                    }
                    .navigationBarTitle(Text("Profile Edit"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.updateUser()
                    }, label: {
                        if case ProfileUIState.updateLoading = viewModel.uiState{
                            ProgressView()
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(.orange)
                        }
                    })
                        .alert(isPresented: .constant(viewModel.uiState == .updateSuccess), content: {
                            Alert(title: Text("Habit"), message: Text("Profile info updated successfuly"))
                        })
                        .opacity(disableDone ? 0: 1)
                    )
                    
                }
            }
            if case ProfileUIState.updateError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("OK")){
                            viewModel.uiState = .none
                        })
                    }
            }
            
            if case ProfileUIState.fetchError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("OK")){
                                viewModel.uiState = .none
                        })
                    }
            }
        }
        .onAppear(perform: {
            viewModel.fetchUser()
        })
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor() ))
}
