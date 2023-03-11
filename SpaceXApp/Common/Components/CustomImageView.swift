//
//  CustomImageView.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 08/03/23.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {
    var imageUrlString:String?
    
    func loadImageUsingUrlString(urlString:String)  {
        imageUrlString = urlString
        
        let url = URL(string:urlString)!
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = imageFromCache as? UIImage
            
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                if imageToCache != nil {
                
                    imageCache.setObject(imageToCache!, forKey: NSString(string: urlString))
                
                    self.image = imageToCache
                }
            }
            
        }.resume()
        
    }
}
