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
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    
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
                print(success)
                self.uiState = .goToHomeScreen
            }
    }

//        interactor.login(request: SignInRequest(email: email, password: password)) { (successResponse, errorResponse) in
//            if let error = errorResponse {
//                DispatchQueue.main.async {
//                    self.uiState = .error(error.detail.message)
//                }
//            }
//
//            if let success = successResponse {
//                DispatchQueue.main.async {
//                    print(success)
//                    self.uiState = .goToHomeScreen
//                }
//            }
//        }
}

extension SignInViewModel {
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
    
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
}
