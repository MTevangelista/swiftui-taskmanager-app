//
//  SignUpUIState.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 23/07/21.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
