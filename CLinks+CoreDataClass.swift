//
//  CLinks+CoreDataClass.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//
//

import Foundation
import CoreData

@objc(CLinks)
public class CLinks: NSManagedObject, Codable {
    required convenience public init(from decoder: Decoder) throws {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
                  let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
                  let entity = NSEntityDescription.entity(forEntityName: "CLinks", in: managedObjectContext) else {
                      fatalError("Failed to decode User")
                  }
            
            self.init(entity: entity, insertInto:managedObjectContext)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.missionPatch  = try container.decodeIfPresent(String.self, forKey: .missionPatch) ?? ""
            self.missionPatchSmall = try container.decodeIfPresent(String.self, forKey: .missionPatchSmall) ?? ""
            self.articleLink = try container.decodeIfPresent(String.self, forKey: .articleLink) ?? ""
            self.wikipedia = try container.decodeIfPresent(String.self, forKey: .wikipedia) ?? ""
            self.videoLink = try container.decodeIfPresent(String.self, forKey: .videoLink) ?? ""
            self.youtubeID = try container.decodeIfPresent(String.self, forKey: .youtubeID) ?? ""
        self.flickrImages = try container.decodeIfPresent([String].self, forKey: .flickrImages) as NSObject?
        
        
        print(self.flickrImages)
            
    //        if self.flickrImages?.count ?? 0 > 0 {
    //            print("Entro")
    //        }
        }
            
            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                
                try container.encode(missionPatch, forKey: .missionPatch)
                try container.encode(missionPatchSmall, forKey: .missionPatchSmall)
                try container.encode(articleLink, forKey: .articleLink)
                try container.encode(wikipedia, forKey: .wikipedia)
                try container.encode(videoLink, forKey: .videoLink)
                try container.encode(youtubeID, forKey: .youtubeID)
            }
}
