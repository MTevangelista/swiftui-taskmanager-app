//
//  SignInView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 21/07/21.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel

    @State var action: Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        ZStack {
            if case SignInUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true), content: {
                        Alert(title: Text("Task Manager"), message: Text(value), dismissButton: .default(Text("OK")) {
                            // faz algo quando some o alerta
                        })
                    })
            }
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationView {
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer(minLength: 36)
                            
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 4)
                                    .frame(width: 200, height: 100, alignment: .center)
                                
                                Text("Login")
                                    .foregroundColor(.orange)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 6)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                
                                Text("Copyright - Nome da Empresa 2021")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 13).bold())
                                    .padding(.top, 16)
                            }
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .default,
                     error: "Senha deve ter ao menos 8 caracteres",
                     failure: viewModel.password.hasMinLenght(value: viewModel.password, min: 8),
                     isSecure: true)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(action: {
            viewModel.login()
        },
        text: "Entrar",
        showProgress: viewModel.uiState == SignInUIState.loading,
        disabled: !viewModel.email.isEmail() ||
            viewModel.password.hasMinLenght(value: viewModel.password, min: 8))
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink(
                    destination: viewModel.signUpView(),
                    tag: 1,
                    selection: $action,
                    label: { EmptyView() })
                
                Button("Realize seu cadastro") {
                    self.action = 1
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        ForEach(ColorScheme.allCases, id: \.self) {
            SignInView(viewModel: viewModel)
                .preferredColorScheme($0)
        }
    }
}
