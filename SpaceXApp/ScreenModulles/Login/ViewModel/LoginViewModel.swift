//
//  LoginViewModel.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//

import Foundation
import CoreText
import Combine
import FirebaseAuth

protocol LoginViewModelProtocol {
    var state : PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
}


final class LoginViewModel: LoginViewModelProtocol {
    var coordinator: AppCoordinator!
    var state: PassthroughSubject<StateController, Never>
    
    @Published var userName = ""
    @Published var password = ""
    @Published var isEnabled = false
    @Published var isHiddenError = true
    
    var cancellables = Set<AnyCancellable>()
    
    init(state: PassthroughSubject<StateController, Never>) {
        self.state = state
        formValidation()
    }
    
    func formValidation() {
        Publishers.CombineLatest ($userName, $password)
            .receive(on: DispatchQueue.main)
            .sink { value1, value2 in
                if value1.count > 1 && value2.count > 1{
                    self.isEnabled = true
                } else {
                    self.isEnabled = false
                }
                self.isHiddenError = true
        }.store(in: &cancellables)
    }
    
    
    @MainActor
    func authenticate()   {
        state.send(.loading)
        
        Auth.auth().signIn(withEmail: userName, password: password) { [weak self] (result, error) in
            if let _ = result, error == nil {
                self?.state.send(.success)
                self?.coordinator.startHome()
            } else {
                self?.isHiddenError = false
                self?.state.send(.fail(error: error?.localizedDescription ?? ""))
            }
        }
    }

    func viewDidLoad() {
        
    }
}

