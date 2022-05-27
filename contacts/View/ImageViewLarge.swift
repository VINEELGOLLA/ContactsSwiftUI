//
//  ImageViewLarge.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import SwiftUI

struct ImageViewLarge: View {
    @ObservedObject var urlImageModel: UrlImageModel
    static var defaultImage = UIImage(named: "photo_gallery")
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? ImageViewLarge.defaultImage!)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)            
    }
}

struct ImageViewLarge_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewLarge(urlString: nil)
    }
}
