//
//  ProfileViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/11/2023.
//

import Foundation
import Combine


class ProfileViewModel: ObservableObject{
    
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneNumberValidation = PhoneNumberValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var fiscalDocument = ""
    @Published var gender: Gender?
    
    private var cancellableFetch: AnyCancellable?
    private var cancellableUpdate: AnyCancellable?
    
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableFetch?.cancel()
        cancellableUpdate?.cancel()
    }
    
    func fetchUser(){
        self.uiState = .loading
        
        cancellableFetch = interactor.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion  in
                switch(completion){
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: {response in
                self.userId = response.id
                self.email = response.email
                self.fiscalDocument = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidation.value = response.fullName
                self.phoneNumberValidation.value = response.phoneNumber
                
                               
                //Take a string -> dd/MM/yyyy -> Date
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                let dateFormatted = formatter.date(from: response.birthday)
                
                // Validation Date
                guard let dateFormatted = dateFormatted else {
                    self.uiState = .fetchError("Invalid date: \(response.birthday)")
                    return
                }
                
                //Date -> dd/MM/yyyy   
                formatter.dateFormat = "dd/MM/yyyy"
                let birthday = formatter.string(from: dateFormatted)
                
                
                self.birthdayValidation.value = birthday
                self.uiState = .fetchSuccess
            })
    }
    
    func updateUser(){
        self.uiState = .updateLoading
        guard let userId = userId,
              let gender = gender else {return}
        
        //Take a string -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthdayValidation.value)
        
        // Validation Date
        guard let dateFormatted = dateFormatted else {
            self.uiState = .updateError("Invalid date: \(birthdayValidation.value)")
            return
        }
        
        //Date -> yyyy-MM-dd
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        cancellableUpdate = interactor.updateUser(userId: userId,
                                                  profileRequest: ProfileRequest(fullName: fullNameValidation.value,
                                                                                 phoneNumber: phoneNumberValidation.value,
                                                                                 birthday: birthday,
                                                                                 gender: gender.index))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                case .failure(let appError):
                    self.uiState = .updateError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: {response in
                self.uiState = .updateSuccess
            })
    }
}

class FullNameValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "" {
        didSet{
            failure = value.count < 3
        }
    }
}

class PhoneNumberValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "" {
        didSet{
            failure = value.count < 9 || value.count >= 10
        }
    }
}

class BirthdayValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "" {
        didSet{
            failure = value.count != 10
        }
    }
}

