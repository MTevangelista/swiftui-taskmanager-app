//
//  Date+Extension.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 05/08/21.
//

import Foundation

extension Date {
    func toString(destPattern dest: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dest
        
        return formatter.string(from: self)
    }
}
