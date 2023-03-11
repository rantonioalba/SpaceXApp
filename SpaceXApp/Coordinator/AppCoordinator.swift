//
//  AppCoordinator.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//
import Foundation
import UIKit
import Combine

class AppCoordinator: NSObject, Coordinator {
    var children: [Coordinator] = []
    
    private let window : UIWindow!
    let navigationController = UINavigationController()
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        self.perform(#selector(startLogin), with: nil, afterDelay: 3.0)
        let splashViewController = SplashScreenViewController()
        if let window = window {
            window.rootViewController = splashViewController
            window.makeKeyAndVisible()
        }
    }
    
    @objc func startLogin()  {
        let loginController = LoginView()
        let state = PassthroughSubject<StateController, Never>()
        let viewModel = LoginViewModel(state: state)
        viewModel.coordinator = self
        loginController.viewModel = viewModel
        
        if let window = window {
            window.rootViewController = loginController
            window.makeKeyAndVisible()
        }
    }
    
    @objc func startHome()  {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
                
        children.append(homeCoordinator)
        
        if let window = window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
