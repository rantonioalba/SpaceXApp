//
//  SplashScreenViewModel.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//

import Foundation
import UIKit

class SplashScreenViewModel {
    var coordinator : SplashCoordinator
    
    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
    }
    
    func didFinish() {
        coordinator.didFinish()
    }
}

