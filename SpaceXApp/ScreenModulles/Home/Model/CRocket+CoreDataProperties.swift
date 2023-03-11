//
//  CRocket+CoreDataProperties.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//
//

import Foundation
import CoreData


extension CRocket {
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CRocket> {
        return NSFetchRequest<CRocket>(entityName: "CRocket")
    }

    @NSManaged public var rocketID: String?
    @NSManaged public var rocketName: String?
    @NSManaged public var rocketType: String?

}

extension CRocket : Identifiable {

}
