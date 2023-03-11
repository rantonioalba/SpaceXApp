//
//  RocketLaunch.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import Foundation

struct RocketLaunch: Codable {
    let flightNumber: Int?
    let missionName: String?
    let launchDateUTC: String?
    let rocket: Rocket?
    let launchSite: RocketLaunchSite?
    let links: Links?
    let details: String?
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchDateUTC = "launch_date_utc"
        case rocket
        case launchSite = "launch_site"
        case links, details
    }
}

