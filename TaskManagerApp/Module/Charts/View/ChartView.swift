//
//  ChartView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 25/10/21.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
            .frame(maxWidth: .infinity, maxHeight: 350)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ChartView(viewModel: ChartViewModel())
                .preferredColorScheme($0)
        }
    }
}
