//
//  SignUpViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 23/07/21.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    @Published var uiState: SignUpUIState = .none
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    func signUp() {
        self.uiState = .loading
        
        // Pegar a String -> dd/MM/yyyy -> Data
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        // Validar a Data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdayFormatted = formatter.string(from: dateFormatted)
        
        WebService.postUser(request: SignUpRequest(fullName: fullName,
                                           email: email,
                                           password: password,
                                           document: document,
                                           phone: phone,
                                           birthday: birthdayFormatted,
                                           gender: gender.index)) { (successResponse, errorResponse) in
             
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
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
