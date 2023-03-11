//
//  CLinks+CoreDataProperties.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 10/03/23.
//
//

import Foundation
import CoreData


extension CLinks {
    enum CodingKeys: String, CodingKey {
            case missionPatch = "mission_patch"
            case missionPatchSmall = "mission_patch_small"
            case articleLink = "article_link"
            case wikipedia
            case videoLink = "video_link"
            case youtubeID = "youtube_id"
            case flickrImages = "flickr_images"
        }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CLinks> {
        return NSFetchRequest<CLinks>(entityName: "CLinks")
    }

    @NSManaged public var articleLink: String?
    @NSManaged public var imagesflickr: String?
    @NSManaged public var missionPatch: String?
    @NSManaged public var missionPatchSmall: String?
    @NSManaged public var videoLink: String?
    @NSManaged public var wikipedia: String?
    @NSManaged public var youtubeID: String?
    @NSManaged public var flickrImages: NSObject?

}

extension CLinks : Identifiable {

}
