//
//  SwiftUIView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 23/07/21.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    @State var gender = Gender.male
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
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
        EditTextView(text: $fullName,
                     placeholder: "Entre com seu nome completo *",
                     keyboard: .alphabet,
                     error: "Nome precisa ter ao menos 3 caracteres",
                     failure: fullName.hasMinLenght(value: fullName, min: 3))
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $email,
                     placeholder: "Entre com seu e-mail *",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $password,
                     placeholder: "Entre com sua senha *",
                     keyboard: .default,
                     error: "Senha precisa ter ao menos 8 caracteres",
                     failure: password.hasMinLenght(value: password, min: 8),
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $document,
                     placeholder: "Entre com seu CPF *",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: document.count != 11)
        // TODO: mask
        // TODO: isDisabled
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $phone,
                     placeholder: "Entre com seu celular *",
                     keyboard: .numberPad,
                     error: "Entre com o DDD + 8 OU 9 digitos",
                     failure: phone.hasMinLenght(value: phone, min: 3) || phone.hasMaxLenght(value: phone, max: 12))
        // TODO: mask
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $birthday,
                     placeholder: "Entre com sua data de nascimento *",
                     keyboard: .default,
                     error: "Data deve ser dd/MM/yyyy",
                     failure: birthday.count != 10)
        // TODO: mask
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("", selection: $gender) {
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
        disabled: !email.isEmail() ||
            password.hasMinLenght(value: password, min: 8) ||
            fullName.hasMinLenght(value: fullName, min: 3) ||
            document.count != 11                           ||
            phone.hasMinLenght(value: phone, min: 10)      ||
            phone.hasMaxLenght(value: phone, max: 12)      ||
            birthday.count != 10)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView(viewModel: SignUpViewModel())
                .preferredColorScheme($0)
        }
    }
}
