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
