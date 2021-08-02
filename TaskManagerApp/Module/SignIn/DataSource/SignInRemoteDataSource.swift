//
//  RemoteDataSource.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 30/07/21.
//

import Foundation
import Combine

// singleton - possui apenas 1 objeto vivo dentro da aplicação
struct SignInRemoteDataSource {
    static var shared: SignInRemoteDataSource = SignInRemoteDataSource()
    
    private init() {
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { promise in
            WebService.call(path: .login  , params: [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name: "password", value: request.password)
            ]) { result in
                switch result {
                case .failure(let error, let data):
                    if error == .unauthorized {
                        guard let data = data else { return }
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        //completion(nil, response)
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
                    guard let response = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    promise(.success(response))
                    //completion(response, nil)
                    break
                }
            }
        }
    }
    
}
