//
//  HabitInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 04/08/21.
//

import Foundation
import Combine

struct HabitInteractor {
    private let remote: HabitRemoteDataSource = .shared
}

// MARK: - Remote Data Source
extension HabitInteractor {
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return remote.fetchHabits()
    }
}
