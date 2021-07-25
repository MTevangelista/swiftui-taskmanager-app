//
//  SignInUIState.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 21/07/21.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
