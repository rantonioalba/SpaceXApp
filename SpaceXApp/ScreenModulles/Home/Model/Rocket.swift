//
//  Rocket.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import Foundation

struct Rocket: Codable {
    let rocketID: String?
    let rocketName: String?
    let rocketType: String?

    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}
