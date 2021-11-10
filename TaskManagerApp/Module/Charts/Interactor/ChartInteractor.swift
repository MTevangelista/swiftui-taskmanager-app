//
//  ChartInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 10/11/21.
//

import Foundation
import Combine

struct ChartInteractor {
    private let remote: ChartRemoteDataSource = .shared
}

// MARK: - Remote Data Source
extension ChartInteractor {
    func fetchHabitValues(by habitId: Int) -> Future<[HabitValueResponse], AppError> {
        return remote.fetchHabitValues(habitId: habitId)
    }
}
