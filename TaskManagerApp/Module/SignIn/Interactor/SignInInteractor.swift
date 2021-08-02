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
    
    func login (request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remote.login(request: request)
    }
}
 
