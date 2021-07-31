//
//  SplashViewRouter.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 21/07/21.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSignInView() -> some View {
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)
    }
    
}
