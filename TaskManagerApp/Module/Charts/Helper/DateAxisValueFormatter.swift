//
//  File.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 27/10/21.
//

import Foundation
import Charts

class DateAxisValueFormatter: IAxisValueFormatter {
    let dates: [String]
    
    init(dates: [String]) {
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let position = Int(value)
        let dateFormatter = DateFormatter()
        let createdAt: String
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if position < 0 && position > dates.count {
            return ""
        }
        guard let date = dateFormatter.date(from: dates[position]) else { return "" }
        dateFormatter.dateFormat = "dd/MM"
        createdAt = dateFormatter.string(from: date)
        return createdAt
    }
}
