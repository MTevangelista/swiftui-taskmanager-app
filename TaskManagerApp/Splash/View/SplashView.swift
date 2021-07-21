//
//  SplashView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 20/07/21.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView() 
            case .goToHomeScreen:
                Text("Carregar tela principal")
            case .error(let msg):
                loadingView(error: msg)
            }
        }
        .onAppear(perform:  viewModel.onAppear)
    }
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true), content: {
                        Alert(title: Text("Task Manager"), message: Text(error), dismissButton: .default(Text("OK")) {
                            // faz algo quando some o alerta
                        })
                    })
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SplashViewModel()
        SplashView(viewModel: viewModel)
    }
}
