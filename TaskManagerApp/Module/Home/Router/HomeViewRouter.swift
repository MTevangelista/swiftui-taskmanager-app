//
//  HomeViewRouter.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView() -> some View {
        let viewModel = HabitViewModel(interactor: HabitInteractor())
        return HabitView(viewModel: viewModel)
    }
    
}
