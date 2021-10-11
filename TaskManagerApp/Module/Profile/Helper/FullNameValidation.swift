//
//  FullNameValidation.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 08/10/21.
//

import Foundation

class FullNameValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = ""  {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = ""  {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = ""  {
        didSet {
            failure = value.count != 10
        }
    }
}
