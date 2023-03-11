//
//  PlayVideoCoordinator.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//

import Foundation
import UIKit
import Combine

final class PlayVideoCoordinator : Coordinator {
    weak var parentCoordinator : DetailCoordinator?
    var children: [Coordinator] = []
    private let rocketLaunch: CRocketLaunch
    private let navigationController : UINavigationController
    
    init(navigationController:UINavigationController, rocketLaunch:CRocketLaunch) {
        self.navigationController = navigationController
        self.rocketLaunch = rocketLaunch
    }
    
    func start() {
        let playVidedoView = PlayVideoView()
        let state = PassthroughSubject<StateController, Never>()
        let viewModel = PlayVideoViewModel(coordinator: self, state: state, videoId: rocketLaunch.links?.youtubeID ?? "")
        playVidedoView.viewModel = viewModel
        playVidedoView.modalPresentationStyle = .fullScreen
        navigationController.present(playVidedoView, animated: true)
    }
    
    func didFinishPlay() {
        navigationController.dismiss(animated: true, completion: nil)
        parentCoordinator?.childDidFinish(self)
    }
}
