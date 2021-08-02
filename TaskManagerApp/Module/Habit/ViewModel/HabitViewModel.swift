//
//  HabitViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var uiState: HabitUIState = .loading
}
