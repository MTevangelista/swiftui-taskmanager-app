//
//  HabitDetailDataSource.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 08/08/21.
//

import Foundation
import Combine

struct HabitDetailDataSource {
    static var shared: HabitDetailDataSource = HabitDetailDataSource()
    
    private init() {}
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return Future { promise in
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .post, body: request) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                    }
                    break
                case .success(_):
                    promise(.success(true))
                    break
                }
            }
        }
    }
}
