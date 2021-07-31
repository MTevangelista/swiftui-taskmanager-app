//
//  SignInInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 30/07/21.
//

import Foundation

struct SignInInteractor {
    private let remote: RemoteDataSource = .shared
    
    func login (request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        remote.login(request: request, completion: completion)
    }
}
