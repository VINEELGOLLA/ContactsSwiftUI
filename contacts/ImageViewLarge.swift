//
//  ImageViewLarge.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import SwiftUI

struct ImageViewLarge: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFit()
            
    }
    
    static var defaultImage = UIImage(named: "photo_gallery")
}

struct ImageViewLarge_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewLarge(urlString: nil)
    }
}
