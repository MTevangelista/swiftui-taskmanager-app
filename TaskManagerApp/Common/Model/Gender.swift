//
//  Gender.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 23/07/21.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    
    var id: String {
        self.rawValue
    }
}
