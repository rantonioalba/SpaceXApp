//
//  CRocket+CoreDataClass.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//
//

import Foundation
import CoreData

@objc(CRocket)
public class CRocket: NSManagedObject, Codable {
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
              let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "CRocket", in: managedObjectContext) else {
                  fatalError("Failed to decode User")
              }
        
        self.init(entity: entity, insertInto:managedObjectContext)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rocketID  = try container.decodeIfPresent(String.self, forKey: .rocketID) ?? ""
        self.rocketName = try container.decodeIfPresent(String.self, forKey: .rocketName) ?? ""
        self.rocketType = try container.decodeIfPresent(String.self, forKey: .rocketType) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rocketID, forKey: .rocketID)
        try container.encode(rocketName, forKey: .rocketName)
        try container.encode(rocketType, forKey: .rocketType)
        
    }
}
