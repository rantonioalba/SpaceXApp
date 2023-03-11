//
//  Coordinator.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import Foundation

protocol Coordinator {
    var children : [Coordinator] { get }
    func start()
}
