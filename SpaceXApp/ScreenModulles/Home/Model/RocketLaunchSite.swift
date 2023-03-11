//
//  RocketLaunchSite.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 07/03/23.
//

import Foundation

struct RocketLaunchSite: Codable {
    var siteId: String?
    var siteName: String?
    var siteNameLong: String?
    
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }
}
