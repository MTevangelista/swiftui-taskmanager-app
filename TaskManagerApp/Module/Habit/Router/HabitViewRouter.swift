//
//  HabitViewRouter.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 29/11/21.
//

import SwiftUI
import Combine

enum HabitViewRouter {
    
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
        
        viewModel.habitPublisher = habitPublisher
        return HabitCreateView(viewModel: viewModel)
    }
    
}
