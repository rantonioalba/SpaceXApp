//
//  DetailCoordinator.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import UIKit
import Combine

final class DetailCoordinator : Coordinator {
    weak var parentCoordinator : HomeCoordinator?
    var children: [Coordinator] = []
    private let rocketLaunch: CRocketLaunch
    private let navigationController : UINavigationController
    
    init(navigationController:UINavigationController, rocketLaunch:CRocketLaunch) {
        self.navigationController = navigationController
        self.rocketLaunch = rocketLaunch
    }
    
    func start() {
        let detailView = HomeDetailView()
        let state = PassthroughSubject<StateController, Never>()
        let viewModel = HomeDetailViewModel(coordinator: self, state: state, launch: rocketLaunch)
        detailView.viewModel = viewModel
        navigationController.pushViewController(detailView, animated: true)
    }
    
    func startVideo() {
        let playVideoCoordinator = PlayVideoCoordinator(navigationController: navigationController, rocketLaunch: rocketLaunch)
        playVideoCoordinator.parentCoordinator = self
        children.append(playVideoCoordinator)
        playVideoCoordinator.start()
    }
    
    func startInfo() {
        let infoCoordinator = InfoCoordinator(navigationController: navigationController, articleLink: rocketLaunch.links?.articleLink ?? "")
        infoCoordinator.parentCoordinator = self
        children.append(infoCoordinator)
        infoCoordinator.start()
    }
    
    func didFinishDetail() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func childDidFinish(_ child: Coordinator?)  {
        for (index, coordinator) in children.enumerated() {
            if coordinator as? DetailCoordinator === child as? DetailCoordinator {
                children.remove(at: index)
            }
        }
    }
}
