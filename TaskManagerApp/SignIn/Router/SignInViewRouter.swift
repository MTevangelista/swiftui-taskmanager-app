//
//  SignInViewRouter.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 22/07/21.
//

import SwiftUI

enum SignInViewRouter {
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
}
