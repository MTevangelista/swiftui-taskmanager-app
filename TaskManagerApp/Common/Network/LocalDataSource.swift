//
//  LocalDataSource.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import Foundation
import Combine

struct LocalDataSource {
    static var shared: LocalDataSource = LocalDataSource()
    
    private init() {}
    
    func insertUserAuth(userAuth: UserAuth) {
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(forKey: "user_key")
        
        return Future { promise in
            promise(.success(userAuth))
        }
    }
}

extension LocalDataSource {
    private func saveValue(value: UserAuth) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    private func readValue(forKey key: String) -> UserAuth? {
        var userAuth: UserAuth?
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
        
        userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        return userAuth
    }
}
