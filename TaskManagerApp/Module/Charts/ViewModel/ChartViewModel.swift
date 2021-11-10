//
//  ChartViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 26/10/21.
//

import Foundation
import SwiftUI
import Charts

class ChartViewModel: ObservableObject {
    @Published var entries: [ChartDataEntry] = [
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 2.0, y: 5.0),
        ChartDataEntry(x: 3.0, y: 6.0),
        ChartDataEntry(x: 4.0, y: 1.0),
        ChartDataEntry(x: 5.0, y: 4.0),
        ChartDataEntry(x: 6.0, y: 4.0),
        ChartDataEntry(x: 7.0, y: 5.0),
        ChartDataEntry(x: 8.0, y: 9.0),
        ChartDataEntry(x: 9.0, y: 8.0),
        ChartDataEntry(x: 10.0, y: 7.0)
    ]
    
    @Published var dates = [
        "2021-01-01",
        "2021-01-02",
        "2021-01-03",
        "2021-01-04",
        "2021-01-05",
        "2021-01-06",
        "2021-01-07",
        "2021-01-08",
        "2021-01-09",
        "2021-01-10"
    ]
}
