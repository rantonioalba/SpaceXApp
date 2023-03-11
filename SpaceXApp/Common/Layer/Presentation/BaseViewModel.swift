//
//  BaseViewModel.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//

import Foundation
import Combine

protocol BaseViewModel {
    var state : PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
}
