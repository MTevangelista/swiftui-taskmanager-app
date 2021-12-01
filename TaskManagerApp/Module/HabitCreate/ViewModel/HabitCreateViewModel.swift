//
//  HabitCreateViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 29/11/21.
//

import Combine
import SwiftUI

class HabitCreateViewModel: ObservableObject {
    @Published var uiState: HabitDetailUIState = .none
    @Published var name = ""
    @Published var label = ""
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = Data()

    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?

    let interactor: HabitDetailInteractor
    
    init(interactor: HabitDetailInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func save() {
        self.uiState = .loading
    }
}
