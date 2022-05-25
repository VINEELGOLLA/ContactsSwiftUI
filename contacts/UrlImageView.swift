//
//  UrlImageView.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import SwiftUI

struct UrlImageView: View {
    
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
    }
    
    static var defaultImage = UIImage(named: "photo_gallery")
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView(urlString: nil)
    }
}
