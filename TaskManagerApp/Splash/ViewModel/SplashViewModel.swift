//
//  SplashViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 20/07/21.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    func onAppear() {
        // faz algo assincrono e muda o estado de uiState
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // aqui é chamado após 2 segundos
            self.uiState = .goToSignInScreen
        }
    }
    
}
