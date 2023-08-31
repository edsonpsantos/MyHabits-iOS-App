//
//  SignUpView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 17/08/2023.
//

import SwiftUI


struct SignUpView : View{
    
 
    
    @ObservedObject var viewModel: SignUpViewModel
    
    
    var body: some View{
        ZStack{
            ScrollView(showsIndicators: false){
                VStack(alignment: .center){
                    VStack(alignment: .leading, spacing: 8){
                        Text("Register")
                            .foregroundColor(Color("textColor"))
                            .font(.system(.title).bold())
                            .padding(.bottom,8)
                        
                        fullNameField
                        emailField
                        passwordField
                        documentField
                        phoneNumberField
                        birthDayField
                        genderField
                        saveButton
                    }
                    Spacer()
                }.padding(.horizontal,8)
            }.padding(20)
            
            if case SignUpUIState.error(let value) = viewModel.uiState{
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("My Habits"), message: Text(value), dismissButton: .default(Text("Ok")){
                            //fazer algo quando some o alert
                        })
                    }
            }
        }
    }
}


/* EXTENSION AREA*/
extension SignUpView{
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Your Full Name *",
                     keyboard: .alphabet,
                     error: "Invalid Full Name",
                     failure: viewModel.fullName.count < 3)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Your E-amil address *",
                     keyboard: .emailAddress,
                     error: "Invalid e-mail format",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View{
        EditTextView(text: $viewModel.password,
                     placeholder: "Your Password *",
                     keyboard: .emailAddress,
                     error: "The password must have at least 8 characters",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignUpView{
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "Your Fiscal Doc Number",
                     keyboard: .numberPad,
                     error: "Invalid document",
                     failure: viewModel.document.count != 12)
        // TODO: mask
        // TODO: isDisabled
    }
}

extension SignUpView {
   var phoneNumberField: some View{
       EditTextView(text: $viewModel.phoneNumber,
                     placeholder: "Your mobile number",
                     keyboard: .numberPad,
                     error: "Invalid mobile number format",
                    failure: viewModel.phoneNumber.count < 9 || viewModel.phoneNumber.count  >= 10
                    )
    }
}

extension SignUpView {
    var birthDayField: some View {
        EditTextView(text: $viewModel.birthDay,
                     placeholder: "Your birthDay date",
                     keyboard: .default,
                     error: "Invalid date format",
                     failure: viewModel.birthDay.count != 10)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender){
            ForEach(Gender.allCases, id: \.self){
                value in Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top,16)
            .padding(.bottom,32)
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action:{viewModel.signUp()},
                          text: "Save",
                          disabled: !viewModel.email.isEmail() ||
                          viewModel.password.count < 8 ||
                          viewModel.fullName.count < 3 ||
                          viewModel.document.count != 12 ||
                          viewModel.phoneNumber.count < 9 || viewModel.phoneNumber.count  >= 10 ||
                          viewModel.birthDay.count != 10,
                          showProgressBar: self.viewModel.uiState == SignUpUIState.loading)
    }
}




struct SignUpView_Previews: PreviewProvider{
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self) { colorValue in
            VStack{
                SignUpView(viewModel: SignUpViewModel())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme(colorValue)
            
        }
    }
}
