//
//  SignUpRemoteDataSource.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 31/07/21.
//

import Foundation
import Combine

struct SignUpRemoteDataSource {
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init() {}
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
        return Future { promise in
            WebService.call(path: .postUser, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if error == .badRequest {
                        guard let data = data else { return }
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")))
                        //completion(nil, response)
                    }
                    break
                case .success(_):
                    promise(.success(true))
                    //completion(true, nil)
                    break
                }
            }
        }
    }
}
