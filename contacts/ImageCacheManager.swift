//
//  ImageCacheManager.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import Foundation
import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private var userContactMananger:[String:UIImage] = [String:UIImage]()
    
    func getImageFromUserWithURL(string: String) -> UIImage? {
        return userContactMananger[string]
    }
    
    func save(image: UIImage, forUrlString str: String) {
        userContactMananger[str] = image
    }
    
    func resetImageCache() {
        userContactMananger.removeAll()
    }

}
