//
//  HabitCreateDataSource.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 01/12/21.
//

import Foundation
import Combine

// singleton - possui apenas 1 objeto vivo dentro da aplicação
struct HabitCreateRemoteDataSource {
    static var shared: HabitCreateRemoteDataSource = HabitCreateRemoteDataSource()
    
    private init() {
    }
    
    func saveHabit(request: HabitCreateRequest) -> Future<Void, AppError> {
        return Future { promise in
            WebService.call(path: .habits, params: [
                URLQueryItem(name: "name", value: request.name),
                URLQueryItem(name: "label", value: request.label)
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
                case .success(_):
                    promise(.success( () ))
                    break
                }
            }
        }
    }
}
