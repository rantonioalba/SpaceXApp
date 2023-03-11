//
//  PlayVideoViewModel.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//

import Foundation
import Combine

protocol PlayVideoViewModelProtocol : BaseViewModel {
    func getVideoId() -> String
    func exitPlayer()
}

class PlayVideoViewModel :  PlayVideoViewModelProtocol {
    private let videoId: String
    private weak var coordinator: PlayVideoCoordinator?
    var state: PassthroughSubject<StateController, Never>
    
    init (coordinator: PlayVideoCoordinator, state: PassthroughSubject<StateController, Never>, videoId:String) {
        self.coordinator = coordinator
        self.state = state
        self.videoId = videoId
    }
    
    func viewDidLoad() { }
    
    func getVideoId() -> String {
        return videoId
    }
    
    func exitPlayer()  {
        coordinator?.didFinishPlay()
    }
}
