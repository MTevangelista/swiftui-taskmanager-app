//
//  NSMutableData+Extension.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/12/21.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String) {
        append(string.data(using: .utf8, allowLossyConversion: true)!)
    }
}
