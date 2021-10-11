//
//  ProfileView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/09/21.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @State var email = "teste3030@gmail.com"
    @State var cpf = "111.222.333-74"
    @State var birthday = "00/00/000"
    @State var selectedGender: Gender? = .male
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure
            || viewModel.phoneValidation.failure
            || viewModel.birthdayValidation.failure
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                Form {
                    Section(header: Text(ProfileConstants.Form.headerTitle)) {
                        presentField(withTitle: ProfileConstants.Field.name.title,
                                     textFieldPlaceholder: ProfileConstants.Field.name.placeholder,
                                     textFieldText: $viewModel.fullNameValidation.value,
                                     keyboardType: .alphabet)
                        
                        if viewModel.fullNameValidation.failure {
                            Text(ProfileConstants.ErrorMessage.invalidName)
                                .foregroundColor(.red)
                        }
                        
                        presentField(withTitle: ProfileConstants.Field.email,
                                     textFieldText: $email,
                                     isDisabled: true)
                        
                        presentField(withTitle: ProfileConstants.Field.cpf,
                                     textFieldText: $cpf,
                                     isDisabled: true)
                        
                        presentField(withTitle: ProfileConstants.Field.phone.title,
                                     textFieldPlaceholder: ProfileConstants.Field.phone.placeholder,
                                     textFieldText: $viewModel.phoneValidation.value,
                                     keyboardType: .numberPad)
                        
                        if viewModel.phoneValidation.failure {
                            Text(ProfileConstants.ErrorMessage.invalidPhone)
                                .foregroundColor(.red)
                        }
                        
                        presentField(withTitle: ProfileConstants.Field.birthday.title,
                                     textFieldPlaceholder: ProfileConstants.Field.birthday.placeholder,
                                     textFieldText: $viewModel.birthdayValidation.value)
                        
                        if viewModel.birthdayValidation.failure {
                            Text(ProfileConstants.ErrorMessage.invalidDate)
                                .foregroundColor(.red)
                        }
                        
                        NavigationLink(
                            destination: GenderSelectorView(selectedGender: $selectedGender,
                                                            genders: Gender.allCases,
                                                            title: ProfileConstants.Navigation.selectGender),
                            label: {
                                Text(ProfileConstants.Navigation.gender)
                                Spacer()
                                Text(selectedGender?.rawValue ?? "")
                            })
                    }
                    
                }
                
            }
            
            .navigationBarTitle(Text(ProfileConstants.Navigation.barTitle), displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: ProfileConstants.Icon.checkmark)
                    .foregroundColor(.orange)
            }).opacity(disableDone ? 0 : 1))
            
        }
    }
}

extension ProfileView {
    func presentField(withTitle title: String,
                      textFieldPlaceholder placeholder: String = "",
                      textFieldText text: Binding<String>,
                      keyboardType: UIKeyboardType = .default,
                      isDisabled: Bool = false) -> some View {
        HStack {
            Text(title)
            Spacer()
            TextField(placeholder, text: text)
                .disabled(isDisabled)
                .foregroundColor(isDisabled ? .gray : Color(ProfileConstants.Color.whiteAndBlack))
                .keyboardType(keyboardType)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ProfileView(viewModel: ProfileViewModel())
                .colorScheme($0)
        }
        
    }
}
