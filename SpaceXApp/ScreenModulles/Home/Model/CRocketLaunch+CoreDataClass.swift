//
//  CRocketLaunch+CoreDataClass.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//
//

import Foundation
import CoreData

class ArrayOfStringsTransformer : ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let array = value as? [String] else { return nil }
        let boxedData = try! NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
        return boxedData
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            return nil
        }
        
        do {
            let array = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: data) as! [String]
            return array
        } catch {
            return nil
        }
    }
}

@objc(CRocketLaunch)
public class CRocketLaunch: NSManagedObject, Codable {
    required convenience public init(from decoder: Decoder) throws {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
                  let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
                  let entity = NSEntityDescription.entity(forEntityName: "CRocketLaunch", in: managedObjectContext) else {
                      fatalError("Failed to decode User")
                  }
            
            self.init(entity: entity, insertInto:managedObjectContext)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.flightNumber = try container.decodeIfPresent(Int64.self, forKey: .flightNumber) ?? 0
            self.missionName  = try container.decodeIfPresent(String.self, forKey: .missionName) ?? ""
            self.launchDateUTC = try container.decodeIfPresent(String.self, forKey: .launchDateUTC) ?? ""
            self.details = try container.decodeIfPresent(String.self, forKey: .details) ?? ""
            self.rocket = try container.decodeIfPresent(CRocket.self, forKey: CodingKeys.rocket)
            self.launchSite = try container.decodeIfPresent(CRocketLaunchSite.self, forKey: .launchSite)
        self.links = try container.decodeIfPresent(CLinks.self, forKey: .links)
                        
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(flightNumber, forKey: .flightNumber)
            try container.encode(missionName, forKey: .missionName)
            try container.encode(launchDateUTC, forKey: .launchDateUTC)
            try container.encode(details, forKey: .details)
            try container.encode(rocket, forKey: .rocket)
        }
}
