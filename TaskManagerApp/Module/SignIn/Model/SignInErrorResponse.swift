//
//  SignInErrorResponse.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 30/07/21.
//

import Foundation

struct SignInErrorResponse: Decodable {
    let detail: SignInDetailErrorResponse
}

struct SignInDetailErrorResponse: Decodable {
    let message: String
}
