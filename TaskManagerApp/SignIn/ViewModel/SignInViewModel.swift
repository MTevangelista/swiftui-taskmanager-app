//
//  SignInViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 21/07/21.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var uiState: SignInUIState = .none
    
    func login(email: String, password: String) {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.uiState = .goToHomeScreen
        }
    }
}

extension SignInViewModel {
    
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
}
