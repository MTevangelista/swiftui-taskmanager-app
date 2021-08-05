//
//  HabitUIState.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCard])
    case error(String)
}
