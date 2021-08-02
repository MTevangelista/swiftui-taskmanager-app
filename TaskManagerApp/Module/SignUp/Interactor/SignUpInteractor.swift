//
//  SignUpInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 31/07/21.
//

import Foundation
import Combine

struct SignUpInteractor {
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

// MARK: - Local Data Source
extension SignUpInteractor {
    func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
        return remoteSignUp.postUser(request: request)
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.login(request: request)
    }
}

// MARK: - Local Data Source
extension SignUpInteractor {
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
