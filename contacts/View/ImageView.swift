//
//  UrlImageView.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var urlImageModel: UrlImageModel
    static var defaultImage = UIImage(named: "photo_gallery")
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? ImageView.defaultImage!)
            .resizable()
    }
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlString: nil)
    }
}
