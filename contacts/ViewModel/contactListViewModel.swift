//
//  contactListViewModel.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import Foundation

class ContactListViewModel: ObservableObject {
    
    private(set) var contactData: [userContact] = []
    @Published var state: ResultState = .loading
    @Published var isFailure: Bool = false
    
    var currentPage = 1
    var isFull: Bool = false
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        NetworkManager.shared.fetchDataWith(pageNum: String(currentPage), onCompletion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let contactData = data, let userContactResults = contactData.results {
                        self?.contactData.append(contentsOf: userContactResults)
                        if userContactResults.count < 20 {
                            self?.isFull = true
                        } else {
                            if let currPage = self?.currentPage {
                                self?.currentPage = currPage + 1
                            }
                        }
                        self?.state = .success(content: self?.contactData ?? [] )
                    }
                case .failure(let error):
                    self?.state = .failed(error: error)
                    self?.isFailure = true
                }
            }
        })
    }
}

