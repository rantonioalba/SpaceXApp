//
//  EndPoint.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import Foundation

protocol EndPoint {
    var base : String {get}
    var path: String {get}
}

extension EndPoint {
    var urlComponents:URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }
    
    var url : String {
        let urlString = (urlComponents.url?.absoluteString)!
        return urlString
    }
}
