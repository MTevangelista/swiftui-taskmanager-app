//
//  HabitRemoteDataSource.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 04/08/21.
//

import Foundation
import Combine

struct HabitRemoteDataSource {
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    private init() {}
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return Future { promise in
            WebService.call(path: .habits, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Error desconhecido no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    guard let response = try? decoder.decode([HabitResponse].self, from: data) else {
                        print("Log: Error parser \(String(describing: String(data: data, encoding: .utf8)))")
                        return
                    }
                    
                    promise(.success(response))
                    break
                }
            }
        }
    }
}
