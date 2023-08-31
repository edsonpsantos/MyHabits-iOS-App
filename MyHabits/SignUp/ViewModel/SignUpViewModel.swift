//
//  SignUpViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 17/08/2023.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
 
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var document: String = ""
    @Published var phoneNumber: String = ""
    @Published var birthDay: String = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool,Never>!
    
    @Published var uiState: SignUpUIState = .none
    
    
    func signUp() {
        self.uiState = .loading
        
        //Take a string -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthDay)
        
        // Validation Date
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Invalid date: \(birthDay)")
            return
        }
        
        //Date -> yyyy-MM-dd
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        WebService.postUser(request: SignUpRequest(fullName: fullName,
                                                   email: email,
                                                   password: password,
                                                   document: document, 
                                                   phoneNumber: phoneNumber,
                                                   birthday: birthday,
                                                   gender: gender.index))
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 2){
       //     //self.uiState = .error("User already exist!")
       //     self.uiState = .success
       //     self.publisher.send(true)
       // }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
