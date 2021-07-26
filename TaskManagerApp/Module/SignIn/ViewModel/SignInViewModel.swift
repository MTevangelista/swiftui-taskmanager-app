//
//  SignInViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 21/07/21.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var uiState: SignInUIState = .none
    
    private var cancellable: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    
    init() {
        cancellable = publisher.sink { value in
            print("usuário criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.uiState = .goToHomeScreen
        }
    }
}

extension SignInViewModel {
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
    
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
}
