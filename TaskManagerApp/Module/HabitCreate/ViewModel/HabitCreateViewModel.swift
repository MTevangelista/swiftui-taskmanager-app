//
//  HabitCreateViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 29/11/21.
//

import Combine
import SwiftUI

class HabitCreateViewModel: ObservableObject {
    @Published var uiState: HabitCreateUIState = .none
    @Published var name = ""
    @Published var label = ""
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = Data()

    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?

    let interactor: HabitCreateInteractor
    
    init(interactor: HabitCreateInteractor) {
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
        
        cancellable = interactor.saveHabit(request: HabitCreateRequest(imageData: imageData,
                                                                       name: name,
                                                                       label: label))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished: break
                }
            }, receiveValue: {
                self.uiState = .success
                self.habitPublisher?.send(true)
            })
    }
}
