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
        
        //Main Thread execution
        WebService.postUser(signUpRequest: SignUpRequest(fullName: fullName,
                                                   email: email,
                                                   password: password,
                                                   document: document,
                                                   phoneNumber: phoneNumber,
                                                   birthday: birthday,
                                                   gender: gender.index),
                            completion: {(successResponse, errorResponse) in
            //Non Main Thread
            if let error = errorResponse {
                DispatchQueue.main.async {
                    //Main Thread
                    self.uiState = .error((error.detail))
                }
            }
            
            //TODO: Refactor DRY
            if let success = successResponse{
                /*WebService.login(loginRequest: SignInRequest(email: self.email, password: self.password)) {(successResponse, errorResponse) in
                    if let errorSignIn = errorResponse {
                        //Main Thread
                        DispatchQueue.main.async {
                            self.uiState = .error(errorSignIn.detail.message)
                        }
                    }
                    
                    if let successSignIn = successResponse {
                        DispatchQueue.main.async {
                            print(successSignIn)
                            self.publisher.send(success)
                            self.uiState = .success
                        }
                    }
                }*/
            }
        })
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
