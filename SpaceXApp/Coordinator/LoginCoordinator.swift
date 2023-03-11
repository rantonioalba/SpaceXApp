//
//  LoginCoordinator.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//

import Foundation
import UIKit
import Combine

class LoginCoordinator : Coordinator {
    var coordinator : AppCoordinator
    var children: [Coordinator] = []
    
    private let navigationController : UINavigationController
    
    init(navigationController:UINavigationController, coordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.coordinator = coordinator
    }
    
    func start() {
        let loginController = LoginView()
        let state = PassthroughSubject<StateController, Never>()
        let viewModel = LoginViewModel(state: state)
        viewModel.coordinator = coordinator
        loginController.viewModel = viewModel
        
        navigationController.setViewControllers([loginController], animated: true)
//        navigationController.pushViewController(loginController, animated: true)
    }
    
    func goToHome()  {
        navigationController.popToRootViewController(animated: true)
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        children.append(homeCoordinator)
        homeCoordinator.start()
    }
}
