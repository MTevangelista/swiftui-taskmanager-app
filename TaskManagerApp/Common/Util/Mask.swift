//
//  Mask.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 03/12/21.
//

import Foundation

struct Mask {
    
    private static var isUpdating = false
    private static var oldString = ""
    
    private static func replaceChars(full: String) -> String {
        full.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
    public static func present(mask: String, value: String, text: inout String) {
        let str = replaceChars(full: value)
        var valueWithMask = ""
        var _mask = mask
        
        if _mask == "(##) ####-####" {
            if value.count >= 14, value.characterAtIndex(index: 5) == "9" {
                _mask = "(##) #####-####"
            }
        }
        
        if str <= oldString { // estou deletanto
            isUpdating = true
            if _mask == "(##) #####-####", value.count == 14 {
                _mask = "(##) ####-####"
            }
        }
         
        if (isUpdating || value.count == mask.count) {
            oldString = str
            isUpdating = false
            return
        }
        
        var i = 0
        for char in _mask {
            if char != "#" && str.count > oldString.count {
                valueWithMask = valueWithMask + String(char)
                continue
            }
            let unamed = str.characterAtIndex(index: i)
            guard let char = unamed else { break }
            valueWithMask = valueWithMask + String(char)
            i = i + 1
        }
        
        isUpdating = true
        if valueWithMask == "(0)" {
            text = ""
            return
        }
        text = valueWithMask
    }
    
}
