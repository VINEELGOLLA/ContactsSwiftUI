//
//  UserContactImageView.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import Foundation

class UserContactImageView: UIImageView {
    
    private var imageUrlString: String?
    
    
    private var userImageLoadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .red
        return activityIndicator
    }()

    init() {
        super.init(image: UIImage(named: "ContactImagePlaceHolder"))
        setupImageLoadingIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func setupImageLoadingIndicator() {
        self.addSubview(userImageLoadingIndicator)
        userImageLoadingIndicator.pin(to: self)
    }
    
    private func animateImageLoadingIndicator(_ flag: Bool) {
        
        if flag {
            userImageLoadingIndicator.isHidden = !flag
            userImageLoadingIndicator.startAnimating()
            return
        }
            userImageLoadingIndicator.isHidden = !flag
            userImageLoadingIndicator.stopAnimating()
    }
    
    
    
    func loadUserImageFrom(imageURL:String) {
        if let userImage = imageCache.getImageFromUserWithURL(string: imageURL) {
            self.image = userImage
            return
        }
        
        if let url = URL(string: imageURL) {
            imageUrlString = imageURL
            self.image = UIImage(named: "ContactImagePlaceHolder")
            animateImageLoadingIndicator(true)
            URLSession.shared.dataTask(with: url) { (data, responce, error) in
                DispatchQueue.main.async {
                    if error == nil, let data = data, let userImage = UIImage(data: data) {
                        self.imageCache.save(image: userImage, forUrlString: imageURL)
                        if self.imageUrlString == imageURL {
                            self.image = userImage
                        }
                    }
                    self.animateImageLoadingIndicator(false)
                    return
                }
            }.resume()
        }
    }
}

