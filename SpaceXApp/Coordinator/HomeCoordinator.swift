//
//  HomeCoordinator.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import UIKit
import Combine

final class HomeCoordinator : Coordinator {
    var children: [Coordinator] = []
    
    private let navigationController : UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeController = HomeView()
        let state = PassthroughSubject<StateController, Never>()
        let viewModel = HomeViewModel(coordinator: self, state: state)
        homeController.viewModel = viewModel
//        homeController.modalPresentationStyle = .fullScreen
//        navigationController.present(homeController, animated: true, completion: nil)
        navigationController.pushViewController(homeController, animated: true)
    }
    
    func startDetail(rocketLaunch:CRocketLaunch)  {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, rocketLaunch: rocketLaunch)
        detailCoordinator.parentCoordinator = self
        children.append(detailCoordinator)
        detailCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?)  {
        for (index, coordinator) in children.enumerated() {
            if coordinator as? DetailCoordinator === child as? DetailCoordinator {
                children.remove(at: index)
            }
        }
    }
}
