//
//  HabitCardView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 03/08/21.
//

import SwiftUI

struct HabitCardView: View {
    let viewModel: HabitCardViewModel
    
    @State private var action = false
    
    var body: some View {
        ZStack(alignment: .trailing, content: {
            NavigationLink(
                destination: Text("Destination"),
                isActive: self.$action,
                label: {
                    EmptyView()
                }
            )
            
            Button(action: {
                self.action = true
            }, label: {
                HStack {
                    Image(systemName: "pencil")
                        .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.name)
                                .foregroundColor(.orange)
                            
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                        }.frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Registrado")
                                .foregroundColor(.orange)
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.value)
                                .foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .cornerRadius(4.0)
            })
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
                .padding()
        })
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.orange, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            NavigationView {
                List {
                    let viewModel = HabitCardViewModel(id: 1,
                                                       icon: "https://via.placeholder.com/150",
                                                       date: "01/01/2021 00:00:00",
                                                       name: "Jogar Futebol",
                                                       label: "horas",
                                                       value: "2",
                                                       state: .green)
                    
                    HabitCardView(viewModel: viewModel)
                    HabitCardView(viewModel: viewModel)
                }
                .frame(maxWidth: .infinity)
                .navigationTitle("Teste")
            }
            .preferredColorScheme($0)
        }
    }
}