//
//  HabitCreateUIState.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 01/12/21.
//

import Foundation

enum HabitCreateUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
