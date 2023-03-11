//
//  InfoCoordinator.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//

import Foundation
import UIKit

final class InfoCoordinator : Coordinator {
    weak var parentCoordinator : DetailCoordinator?
    var children: [Coordinator] = []
    private let navigationController : UINavigationController
    private let articleLink : String
    
    init(navigationController:UINavigationController,
         articleLink:String) {
        self.navigationController = navigationController
        self.articleLink = articleLink
    }
    
    func start() {
        let infoView = InfoView()
        let viewModel = InfoViewModel(coordinator: self, articleLink: articleLink)
        infoView.viewModel = viewModel
        navigationController.pushViewController(infoView, animated: true)
    }
    
    func didFinishInfo()  {
        parentCoordinator?.childDidFinish(self)
    }
}
