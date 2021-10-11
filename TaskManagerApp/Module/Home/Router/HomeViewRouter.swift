//
//  HomeViewRouter.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
    
    static func makeProfileView(viewModel: ProfileViewModel) -> some View {
        return ProfileView(viewModel: viewModel)
    }
    
}
