//
//  GenderSelectorView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 07/10/21.
//

import SwiftUI

struct GenderSelectorView: View {
    @Binding var selectedGender: Gender?
    
    let genders: [Gender]
    let title: String
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(genders, id: \.id) { item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: ProfileConstants.Icon.checkmark)
                            .foregroundColor(selectedGender == item ? .orange : .clear)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == item) {
                            selectedGender = item
                        }
                    }
                }
            }
        }.navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct GenderSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            GenderSelectorView(selectedGender: .constant(.female), genders: Gender.allCases, title: "Teste")
                .colorScheme($0)
        }
        
    }
}
