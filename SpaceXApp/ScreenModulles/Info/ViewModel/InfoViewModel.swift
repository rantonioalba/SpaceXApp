//
//  InfoViewModel.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//

import Foundation

protocol InfoViewModelProtocol {
    func getArticleLinkURL() -> String
    func viewDidDisappear()
}

final class InfoViewModel : InfoViewModelProtocol {
    private weak var coordinator: InfoCoordinator?
    private var articleLink : String
    
    init (coordinator:InfoCoordinator,
          articleLink:String) {
        self.coordinator = coordinator
        self.articleLink = articleLink
    }
    
    func getArticleLinkURL() -> String {
        return articleLink
    }
    
    func viewDidDisappear()  {
        coordinator?.didFinishInfo()
    }
}
