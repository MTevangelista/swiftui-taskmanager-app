//
//  ProfileViewModel.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 08/10/21.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellable: AnyCancellable?
    
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fetchUser() {
        uiState = .loading
        
        cancellable = interactor.fecthUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message)
                    break
                case .finished: break
                }
            }, receiveValue: { response in
                self.userId = response.id
                self.email = response.email
                self.document = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidation.value = response.fullName
                self.phoneValidation.value = response.phone
                self.birthdayValidation.value = response.birthday
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yy-MM-dd"
                
                let dateFormatted = formatter.date(from: response.birthday)
                
                guard let dateFormatted = dateFormatted else {
                    self.uiState = .fetchError("Data inválida \(response.birthday)")
                    return
                }
                
                formatter.dateFormat = "dd/MM/yyyy"
                let birthdayFormatted = formatter.string(from: dateFormatted)
                self.birthdayValidation.value = birthdayFormatted
                self.uiState = .fetchSuccess
            })
    }
}

class FullNameValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "Teste"  {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "11912341234"  {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "20/02/1990"  {
        didSet {
            failure = value.count != 10
        }
    }
}
