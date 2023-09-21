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
    
    @Published var uiState: SignUpUIState = .none
    
    var publisher: PassthroughSubject<Bool,Never>!
    
    private var cancellableSingUP: AnyCancellable?
    private var cancellableSingIn: AnyCancellable?
        
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor){
        self.interactor = interactor
    }
    
    deinit {
        cancellableSingIn?.cancel()
        cancellableSingUP?.cancel()
    }
    
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
        
        let signUpRequest = SignUpRequest(fullName: fullName,
                                          email: email,
                                          password: password,
                                          document: document,
                                          phoneNumber: phoneNumber,
                                          birthday: birthday,
                                          gender: gender.index)
        
        //Main Thread execution
        cancellableSingUP = interactor.postUser(signUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                //Error and Finished
                switch (completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { created  in
                 // success
                if (created) {
                    //Login Step
                    self.cancellableSingIn = self.interactor.login(signInRequest: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch(completion){
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { successSignIn in
                            print(created)
                            self.publisher.send(created)
                            self.uiState = .success
                        }
                    }
                }
        }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
