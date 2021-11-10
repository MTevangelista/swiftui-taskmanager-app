//
//  HabitValueResponse.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 10/11/21.
//

import Foundation

public struct HabitValueResponse: Decodable {
    let id: Int
    let value: Int
    let habitId: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case habitId = "habit_id"
        case createdDate = "created_date"
    }
}
