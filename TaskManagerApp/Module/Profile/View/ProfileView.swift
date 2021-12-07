//
//  ProfileView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/09/21.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure
            || viewModel.phoneValidation.failure
            || viewModel.birthdayValidation.failure
    }
    
    var body: some View {
        ZStack {
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
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
                                             textFieldText: $viewModel.email,
                                             isDisabled: true)
                                
                                presentField(withTitle: ProfileConstants.Field.cpf,
                                             textFieldText: $viewModel.document,
                                             isDisabled: true)
                                
                                presentField(withTitle: ProfileConstants.Field.phone.title,
                                             textFieldPlaceholder: ProfileConstants.Field.phone.placeholder,
                                             textFieldText: $viewModel.phoneValidation.value,
                                             keyboardType: .numberPad,
                                             mask: ProfileConstants.Field.phone.mask)
                                
                                if viewModel.phoneValidation.failure {
                                    Text(ProfileConstants.ErrorMessage.invalidPhone)
                                        .foregroundColor(.red)
                                }
                                
                                presentField(withTitle: ProfileConstants.Field.birthday.title,
                                             textFieldPlaceholder: ProfileConstants.Field.birthday.placeholder,
                                             textFieldText: $viewModel.birthdayValidation.value,
                                             mask: ProfileConstants.Field.birthday.mask)
                                
                                if viewModel.birthdayValidation.failure {
                                    Text(ProfileConstants.ErrorMessage.invalidDate)
                                        .foregroundColor(.red)
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(selectedGender: $viewModel.gender,
                                                                    genders: Gender.allCases,
                                                                    title: ProfileConstants.Navigation.selectGender),
                                    label: {
                                        Text(ProfileConstants.Navigation.gender)
                                        Spacer()
                                        Text(viewModel.gender?.rawValue ?? "")
                                    })
                            }
                            
                        }
                        
                    }
                    .navigationBarTitle(Text(ProfileConstants.Navigation.barTitle), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.updateUser()
                    }, label: {
                        if case ProfileUIState.updateLoading = viewModel.uiState {
                            ProgressView()
                        } else {
                            Image(systemName: ProfileConstants.Icon.checkmark)
                                .foregroundColor(.orange)
                        }
                    })
                    .alert(isPresented: .constant(viewModel.uiState == .updateSuccess), content: {
                        Alert(title: Text("Task Manager"),
                              message: Text("Dados atualizados com suceeso"),
                              dismissButton: .default(Text("OK")) {
                                viewModel.uiState = .none
                              })
                    })
                    .opacity(disableDone ? 0 : 1)
                    )
                }
            }
            
            if case ProfileUIState.updateError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true), content: {
                        Alert(title: Text("Task Manager"), message: Text(value), dismissButton: .default(Text("OK")) {
                            viewModel.uiState = .none
                        })
                    })
            }
            
            if case ProfileUIState.fetchError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true), content: {
                        Alert(title: Text("Task Manager"), message: Text(value), dismissButton: .default(Text("OK")) {
                            // faz algo quando some o alerta
                        })
                    })
            }
        }.onAppear(perform: {
            viewModel.fetchUser()
        })
    }
}

extension ProfileView {
    func presentField(withTitle title: String,
                      textFieldPlaceholder placeholder: String = "",
                      textFieldText text: Binding<String>,
                      keyboardType: UIKeyboardType = .default,
                      isDisabled: Bool = false,
                      mask: String? = nil) -> some View {
        HStack {
            Text(title)
            Spacer()
            ProfileEditTextView(text: text,
                                placeholder: placeholder,
                                mask: mask,
                                keyboard: keyboardType)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
                .colorScheme($0)
        }
        
    }
}
