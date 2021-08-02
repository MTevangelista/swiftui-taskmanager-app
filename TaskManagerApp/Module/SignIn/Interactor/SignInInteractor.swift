//
//  SignInInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 30/07/21.
//

import Foundation
import Combine

struct SignInInteractor {
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

// MARK: - Remote Data Source
extension SignInInteractor {
    func login (request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remote.login(request: request)
    }
}

// MARK: - Local Data Source
extension SignInInteractor {
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
}
