//
//  AppError.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 31/07/21.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
