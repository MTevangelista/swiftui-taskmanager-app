//
//  String+Extension.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 24/07/21.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func hasMinLenght(value: String, min: Int) -> Bool {
        return value.count < min
    }
    
    func hasMaxLenght(value: String, max: Int) -> Bool {
        return value.count > max
    }
    
    func toDate(sourcePattern source: String, destPattern dest: String) -> String? {
        // Pegar a String -> dd/MM/yyyy -> Data
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        
        // Validar a Data
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = dest
        return formatter.string(from: dateFormatted)
    }
    
    func toDate(sourcePattern source: String) -> Date? {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        return formatter.date(from: self)
    }
}
