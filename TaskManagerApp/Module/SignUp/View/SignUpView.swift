//
//  SwiftUIView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 23/07/21.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: true) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        genderField
                        
                        saveButton
                    }
                    Spacer()
                }.padding(.horizontal, 8)
            }.padding()
            
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true), content: {
                        Alert(title: Text("Task Manager"), message: Text(value), dismissButton: .default(Text("OK")) {
                            // faz algo quando some o alerta
                        })
                    })
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Entre com seu nome completo *",
                     keyboard: .alphabet,
                     error: "Nome precisa ter ao menos 3 caracteres",
                     failure: viewModel.fullName.hasMinLenght(value: viewModel.fullName, min: 3),
                     autocapitalization: .words)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Entre com seu e-mail *",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Entre com sua senha *",
                     keyboard: .default,
                     error: "Senha precisa ter ao menos 8 caracteres",
                     failure: viewModel.password.hasMinLenght(value: viewModel.password, min: 8),
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "Entre com seu CPF *",
                     mask: "###.###.###-##",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: viewModel.document.count != 14)
        // TODO: mask
        // TODO: isDisabled
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Entre com seu celular *",
                     mask: "(##) ####-####",
                     keyboard: .numberPad,
                     error: "Entre com o DDD + 8 OU 9 digitos",
                     failure: viewModel.phone.hasMinLenght(value: viewModel.phone, min: 14) ||
                        viewModel.phone.hasMaxLenght(value: viewModel.phone, max: 15))
        // TODO: mask
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Entre com sua data de nascimento *",
                     mask: "##/##/####",
                     keyboard: .numberPad,
                     error: "Data deve ser dd/MM/yyyy",
                     failure: viewModel.birthday.count != 10)
        // TODO: mask
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.init(top: 16, leading: 0, bottom: 32, trailing: 0))
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
        },
        text: "Realize seu cadastro",
        showProgress: viewModel.uiState == SignUpUIState.loading,
        disabled: !viewModel.email.isEmail() ||
            viewModel.password.hasMinLenght(value: viewModel.password, min: 8) ||
            viewModel.fullName.hasMinLenght(value: viewModel.fullName, min: 3) ||
            viewModel.document.count != 14                           ||
            viewModel.phone.hasMinLenght(value: viewModel.phone, min: 14)      ||
            viewModel.phone.hasMaxLenght(value: viewModel.phone, max: 15)      ||
            viewModel.birthday.count != 10)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
                .preferredColorScheme($0)
        }
    }
}
