//
//  HabitViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var uiState: HabitUIState = .emptyList
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado!"
    @Published var description = "Você está atrasado nos hábitos"
}
