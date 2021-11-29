//
//  ChartViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 26/10/21.
//

import Foundation
import SwiftUI
import Charts
import Combine

class ChartViewModel: ObservableObject {
    private let habitId: Int
    private let interactor: ChartInteractor
    private var cancellable: AnyCancellable?
    
    @Published var uiState = ChartUIState.loading
    @Published var entries: [ChartDataEntry] = []
    @Published var dates: [String] = []
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func onAppear() {
        cancellable = interactor.fetchHabitValues(by: habitId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyChart
                    return
                }
                self.dates = response.map { $0.createdDate }
                // [0 ... N], [HabitValueResponse]
                self.entries = zip(response.startIndex..<response.endIndex, response).map { index, response in
                    ChartDataEntry(x: Double(index), y: Double(response.value))
                }
                self.uiState = .fullChart
            })
    }
}
