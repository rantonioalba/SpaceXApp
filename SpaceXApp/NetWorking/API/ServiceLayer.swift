//
//  ServiceLayer.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import Foundation
import Alamofire

public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

protocol APIServiceProtocol {
    func callService<T:Decodable>(_ requestModel: RequestModel, _ modelType:T.Type) async throws -> [T]?
}

class ServiceLayer : APIServiceProtocol {
    
    static let sharedInstance : ServiceLayer = ServiceLayer()
    
    private init() { }
    
    func callService<T:Decodable>(_ requestModel: RequestModel, _ modelType:T.Type) async throws -> [T]? {
        
        var urlString = requestModel.apiURL.url
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        var components = URLComponents(string: urlString)
        
        let params = requestModel.queryItems ?? [:]
        components?.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        var request:URLRequest!
        
        request = URLRequest(url: (components?.url!)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 4.0)
        
        request.httpMethod = requestModel.httpMethod.rawValue
        
        
        
        do {
            let appDelegate = await UIApplication.shared.delegate as! AppDelegate
            let context = await appDelegate.persistentContainer.viewContext
            
            let data = try await alamofireRequest(request: request)
            
            let decoder = JSONDecoder()
            guard let codingUserInfoManagedObjectContext = CodingUserInfoKey.managedObjectContext  else {
                fatalError("Failed to retrieve context")
            }
            
            decoder.userInfo[codingUserInfoManagedObjectContext] = context
            
            let object = try decoder.decode([T]?.self, from: data)
            
            return object
        } catch {
           throw error
        }
    }
}
 
func alamofireRequest(request:URLRequest) async throws -> Data {
    try await withUnsafeThrowingContinuation({ continuation in
        AF.request(request).response { response in
            if let data = response.data {
                continuation.resume(returning: data)
                return
            }
            
            if let err = response.error {
                continuation.resume(throwing: err)
                return
            }
            
        }
    })
}
