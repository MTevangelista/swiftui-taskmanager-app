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
        
        WebService.postUser(fullName: fullName,
                            email: email,
                            password: password,
                            document: document,
                            phone: phone,
                            birthday: birthday, // TODO: formatar no input do teclado (dd/MM/yyyy -> yyyy-MM-dd))
                            gender: gender.index)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            //self.uiState = .error("Usuário já existente")
//            self.uiState = .success
//            self.publisher.send(true)
//        }
    }
}

extension SignUpViewModel {
    
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
    
}
