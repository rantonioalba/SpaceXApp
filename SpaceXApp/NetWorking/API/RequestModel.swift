//
//  RequestModel.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import Foundation
import Alamofire

struct RequestModel {
    var queryItems: [String:String]?
    var httpMethod : HTTPMethod = .get
    var apiURL: APIURL
}


enum APIURL {
    case LAUNCHES
}

extension APIURL:EndPoint {
    var base: String {
        switch self {
        default:
        return "https://api.spacexdata.com"
        }
    }
    
    var path: String {
        switch self {
        case .LAUNCHES:
            return "/v3/launches/past"
        }
    }
}
