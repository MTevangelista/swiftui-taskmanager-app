//
//  HomeViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 22/07/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let viewModel = HabitViewModel(interactor: HabitInteractor())
}

extension HomeViewModel {
    
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
    
}
