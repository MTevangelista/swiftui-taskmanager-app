//
//  SignUpRequest.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 28/07/21.
//

import Foundation

struct SignUpRequest: Encodable {
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case password
        case document
        case phone
        case birthday
        case gender
    }
}
