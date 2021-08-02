//
//  SignUpViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 23/07/21.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    @Published var uiState: SignUpUIState = .none
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
    
    func signUp() {
        self.uiState = .loading
        
        // Pegar a String -> dd/MM/yyyy -> Data
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        // Validar a Data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdayFormatted = formatter.string(from: dateFormatted)
        
        let signUpRequest = SignUpRequest(fullName: fullName,
                                          email: email,
                                          password: password,
                                          document: document,
                                          phone: phone,
                                          birthday: birthdayFormatted,
                                          gender: gender.index)
        
        cancellableSignUp = interactor.postUser(request: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = SignUpUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { created in
                print(created)
                if created {
                    let signInRequest = SignInRequest(email: self.email, password: self.password)
                    self.cancellableSignIn = self.interactor.login(request: signInRequest)
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch completion {
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { successSignIn in
                            print(created)
                            let auth = UserAuth(idToken: successSignIn.accessToken,
                                                refreshToken: successSignIn.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(successSignIn.expires),
                                                tokenType: successSignIn.tokenType)
                            
                            self.interactor.insertAuth(userAuth: auth)
                            self.publisher.send(created)
                            self.uiState = .success
                        }

                }
            })
    }
}

extension SignUpViewModel {
    
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
    
}
