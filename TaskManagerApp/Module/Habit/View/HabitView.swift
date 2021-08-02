//
//  HabitView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case .loading: progress
            case .emptyList:
                EmptyView()
            case .fullList:
                EmptyView()
            case .error(_):
                EmptyView()
            }
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeViewRouter.makeHabitView()
                .preferredColorScheme($0)
        }
    }
}
