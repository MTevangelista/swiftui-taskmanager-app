//
//  ProfileInteractor.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 11/10/21.
//

import Foundation
import Combine

struct ProfileInteractor {
    private let remote: ProfileRemoteDataSource = .shared
}

// MARK: - Remote Data Source
extension ProfileInteractor {
    func fecthUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
}
