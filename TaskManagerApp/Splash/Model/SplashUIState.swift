//
//  SplashUIState.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 20/07/21.
//

import Foundation

public enum SplashUIState {
    case loading
    case goToSignInScreen
    case goToHomeScreen
    case error(String)
}
