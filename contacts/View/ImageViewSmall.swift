//
//  UrlImageView.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import SwiftUI

struct ImageViewSmall: View {
    
    @ObservedObject var urlImageModel: UrlImageModel
    static var defaultImage = UIImage(named: "photo_gallery")
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? ImageViewSmall.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(8)
    }
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewSmall(urlString: nil)
    }
}
