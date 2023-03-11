//
//  CRocketLaunch+CoreDataProperties.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//
//

import Foundation
import CoreData


extension CRocketLaunch {
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchDateUTC = "launch_date_utc"
        case rocket
        case launchSite = "launch_site"
        case links, details
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CRocketLaunch> {
        return NSFetchRequest<CRocketLaunch>(entityName: "CRocketLaunch")
    }

    @NSManaged public var details: String?
    @NSManaged public var flightNumber: Int64
    @NSManaged public var launchDateUTC: String?
    @NSManaged public var missionName: String?
    @NSManaged public var rocket: CRocket?
    @NSManaged public var launchSite: CRocketLaunchSite?
    @NSManaged public var links: CLinks?

}

extension CRocketLaunch : Identifiable {

}
