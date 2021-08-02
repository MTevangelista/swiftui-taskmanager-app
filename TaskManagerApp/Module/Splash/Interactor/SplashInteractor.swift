//
//  SplashInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import Foundation
import Combine

struct SplashInteractor {
    private let local: LocalDataSource = .shared
}

// MARK: - Local Data Source
extension SplashInteractor {
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
}
