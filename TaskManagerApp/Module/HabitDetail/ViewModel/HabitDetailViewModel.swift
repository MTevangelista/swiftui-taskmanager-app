//
//  HabitDetailViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 06/08/21.
//

import Foundation
import Combine
import SwiftUI

class HabitDetailViewModel: ObservableObject {
    @Published var uiState: HabitDetailUIState = .none
    @Published var value = ""
    
    private var cancellable: AnyCancellable?
    
    let id: Int
    let name: String
    let label: String
    let interactor: HabitDetailInteractor
    
    init(id: Int, name: String, label: String, interactor: HabitDetailInteractor) {
        self.id = id
        self.name = name
        self.label = label
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func save() {
        self.uiState = .loading
        
        cancellable = interactor.save(habitId: id, HabitValueRequest: .init(value: value))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished: break
                }
            }, receiveValue: { created in
                self.uiState = .success
            })
    }
}
