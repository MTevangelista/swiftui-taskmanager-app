//
//  HabitCreateInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 01/12/21.
//

import Foundation
import Combine

struct HabitCreateInteractor {
    private let remote: HabitCreateRemoteDataSource = .shared
    
    func saveHabit(request: HabitCreateRequest) -> Future<Void, AppError> {
        remote.saveHabit(request: request)
    }
}
