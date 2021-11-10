//
//  ChartUIState.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 10/11/21.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
