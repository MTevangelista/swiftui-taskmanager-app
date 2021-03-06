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
            if case HabitUIState.loading  = viewModel.uiState {
                progress
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            if !viewModel.isCharts {
                                topContainer
                                addButton
                            }
                            
                            if case HabitUIState.emptyList = viewModel.uiState {
                                emptyState
                            } else if case HabitUIState.fullList(let rows) = viewModel.uiState {
                                fullState(rows: rows)
                            } else if case HabitUIState.error(let msg) = viewModel.uiState {
                                errorState(errorMessage: msg)
                            }
                        }
                    }
                    .navigationTitle("Meus Hábitos")
                }
            }
        }.onAppear {
            if !viewModel.opened {
                viewModel.onAppear()
            }
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(.orange)
            
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.description)
                .font(Font.system(.subheadline).bold())
                .foregroundColor(Color("textColor"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink(destination: viewModel.habitCreateView()) {
            Label("Criar Hábito", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
    }
}

extension HabitView {
    var emptyState: some View {
        VStack {
            Spacer(minLength: 60)
            
            Image(systemName: "exclamationmark.octagon.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24, alignment: .center)
            
            Text("Nenhum hábito encontrado :(")
        }
    }
}

extension HabitView {
    func fullState(rows: [HabitCardViewModel]) -> some View {
        LazyVStack {
            ForEach(rows) { row in
                HabitCardView(isChart: viewModel.isCharts, viewModel: row)
            }
        }
    }
}

extension HabitView {
    func errorState(errorMessage: String) -> some View {
        Text("")
            .alert(isPresented: .constant(true)) {
                Alert(title: Text("Ops! \(errorMessage)"),
                      message: Text("Tentar novamente?"),
                      primaryButton: .default(Text("Sim")) {
                        viewModel.onAppear()
                      },
                      secondaryButton: .cancel())
            }
    }
}


struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeViewRouter.makeHabitView(viewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor()))
                .preferredColorScheme($0)
        }
    }
}
