//
//  CRocketLaunchSite+CoreDataClass.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//
//

import Foundation
import CoreData

@objc(CRocketLaunchSite)
public class CRocketLaunchSite: NSManagedObject, Codable {
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
              let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "CRocketLaunchSite", in: managedObjectContext) else {
                  fatalError("Failed to decode User")
              }
        
        self.init(entity: entity, insertInto:managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.siteId  = try container.decodeIfPresent(String.self, forKey: .siteId) ?? ""
        self.siteName = try container.decodeIfPresent(String.self, forKey: .siteName) ?? ""
        self.siteNameLong = try container.decodeIfPresent(String.self, forKey: .siteNameLong) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(siteId, forKey: .siteId)
        try container.encode(siteName, forKey: .siteName)
        try container.encode(siteNameLong, forKey: .siteNameLong)
    }
}
