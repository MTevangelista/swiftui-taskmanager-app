//
//  HomeView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 02/08/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Text("Conteúdo de hábitos \(selection)")
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Hábitos")
                }.tag(0)
            
            Text("Conteúdo de gráficos \(selection)")
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Gráficos")
                }.tag(1)
            
            Text("Conteúdo de perfil \(selection)")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
        }
        .accentColor(.orange)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HomeView(viewModel: HomeViewModel())
                .preferredColorScheme($0)
        }
    }
}
