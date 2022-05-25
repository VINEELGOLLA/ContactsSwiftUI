//
//  NetworkManager.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import Foundation

protocol Network {
    func fetchDataWith(pageNum: String, onCompletion : @escaping (Result<ContactListResponse?,Error>) -> Void)
}

class NetworkManager: Network {
    
    static let shared = NetworkManager()
        
    func fetchDataWith(pageNum: String, onCompletion : @escaping (Result<ContactListResponse?,Error>) -> Void) {
        
        let newUrl = "https://randomuser.me/api/?page=\(pageNum)&results=20&seed=abc"
        guard let stringUrl = URL(string: newUrl) else { return }
        
        URLSession.shared.dataTask(with: stringUrl, completionHandler: { data, urlResponse, error in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(ContactListResponse.self, from: data)
                        onCompletion(.success(response))
                    } catch let error {
                        onCompletion(.failure(error))
                    }
                }
        }).resume()
    }
}
