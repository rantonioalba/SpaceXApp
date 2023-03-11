//
//  CRocketLaunchSite+CoreDataProperties.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//
//

import Foundation
import CoreData


extension CRocketLaunchSite {
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CRocketLaunchSite> {
        return NSFetchRequest<CRocketLaunchSite>(entityName: "CRocketLaunchSite")
    }

    @NSManaged public var siteId: String?
    @NSManaged public var siteName: String?
    @NSManaged public var siteNameLong: String?
}

extension CRocketLaunchSite : Identifiable {

}
