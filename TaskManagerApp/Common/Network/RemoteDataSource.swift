//
//  RemoteDataSource.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 30/07/21.
//

import Foundation

// singleton - possui apenas 1 objeto vivo dentro da aplicação
struct RemoteDataSource {
    static var shared: RemoteDataSource = RemoteDataSource()
    
    private init() {
    }
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        WebService.call(path: .login  , params: [
            URLQueryItem(name: "username", value: request.email),
            URLQueryItem(name: "password", value: request.password)
        ]) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try? decoder.decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
            case .failure(let error, let data):
                if error == .unauthorized {
                    guard let data = data else { return }
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                    completion(nil, response)
                }
                break
            }
        }
    }
    
}
