//
//  SplashCoordinator.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//

import UIKit

class SplashCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    private let navigationController : UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashViewController = SplashScreenViewController()
        let viewModel = SplashScreenViewModel(coordinator: self)
        splashViewController.viewModel = viewModel
        navigationController.setViewControllers([splashViewController], animated: true)
    }
    
    func didFinish(){
        navigationController.popViewController(animated: false)
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}
