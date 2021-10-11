//
//  ProfileViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 08/10/21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
}

class FullNameValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "Teste"  {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "11912341234"  {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "20/02/1990"  {
        didSet {
            failure = value.count != 10
        }
    }
}
