//
//  HabitDetailUIState.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 06/08/21.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
