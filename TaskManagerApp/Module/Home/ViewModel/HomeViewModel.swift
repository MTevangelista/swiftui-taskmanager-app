//
//  HomeViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 22/07/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let viewModel = HabitViewModel(interactor: HabitInteractor())
    let profileViewModel = ProfileViewModel()
}

extension HomeViewModel {
    
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
    
}
