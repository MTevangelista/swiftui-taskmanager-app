//
//  HabitDetailInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 08/08/21.
//

import Foundation
import Combine

struct HabitDetailInteractor {
    private let remote: HabitDetailDataSource = .shared
}

// MARK: - Remote Data Source
extension HabitDetailInteractor {
    func save(habitId: Int, HabitValueRequest request: HabitValueRequest) -> Future<Bool, AppError> {
        return remote.save(habitId: habitId, request: request)
    }
}
