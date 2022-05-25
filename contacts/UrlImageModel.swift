//
//  urlImageModel.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import Foundation
import SwiftUI

class UrlImageModel: ObservableObject {
    
    @Published var image: UIImage?
    var urlString: String?
    
    private var imageCache = ImageCacheManager.shared
    
    init(_ urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        
        guard let urlString = urlString else {
            return
        }
        
        if let cacheImage  = imageCache.getImageFromUserWithURL(string: urlString) {
            self.image = cacheImage
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            
            guard error == nil else {
                print("error")
                return
            }
            
            guard let data = data else {
                print("data error")
                return
            }
            
            DispatchQueue.main.async {
                guard let urlImage = UIImage(data: data)  else {
                    return
                }
                
                // save image in cache
                self.imageCache.save(image: urlImage, forUrlString: urlString)
                
                self.image = urlImage
        }
        }
        task.resume()
        
    }
    
    
}
