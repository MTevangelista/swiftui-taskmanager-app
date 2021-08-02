//
//  SignInViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 21/07/21.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var uiState: SignInUIState = .none
    @Published var testToken = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    private var testCancellable: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        
        cancellable = publisher.sink { value in
            print("usuário criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func testRequest() {
        testCancellable = interactor.fetchAuth()
            .sink(receiveValue: { userAuth in
                self.testToken = userAuth?.idToken ?? "token ainda não registrado"
            })
    }
    
    func login() {
        self.uiState = .loading
        
        cancellableRequest = interactor.login(request: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = SignInUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { success in
                let auth = UserAuth(idToken: success.accessToken,
                                    refreshToken: success.refreshToken,
                                    expires: success.expires,
                                    tokenType: success.tokenType)
                
                self.interactor.insertAuth(userAuth: auth)
                self.uiState = .goToHomeScreen
            }
    }
}

extension SignInViewModel {
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
    
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
}
