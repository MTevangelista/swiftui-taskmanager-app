//
//  ProfileUIState.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 11/10/21.
//

import Foundation

enum ProfileUIState {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
}
