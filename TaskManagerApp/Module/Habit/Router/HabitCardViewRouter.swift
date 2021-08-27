//
//  HabitCardViewRouter.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 06/08/21.
//

import SwiftUI

enum HabitCardViewRouter {
    
    static func makeHabitDetailView(id: Int, name: String, label: String) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        return HabitDetailView(viewModel: viewModel)
    }
    
}
