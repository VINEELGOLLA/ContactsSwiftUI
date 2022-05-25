//
//  contactListViewModel.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import Foundation

class ContactListViewModel: ObservableObject {
    @Published var contactData: [userContact] = []
    @Published var isLoading: Bool = false
    @Published var isFailure: Bool = false
    
    var currentPage = 1
    var isFull: Bool = false
    
    
    init() {
        isLoading = true
        self.fetchData()
    }
    
    func fetchData() {
        NetworkManager.shared.fetchDataWith(pageNum: String(currentPage), onCompletion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let contactData = data, let userContactResults = contactData.results {
                        self?.isLoading = false
                        self?.contactData.append(contentsOf: userContactResults)
                        if userContactResults.count < 20 {
                            self?.isFull = true
                        } else {
                            if let currPage = self?.currentPage {
                                self?.currentPage = currPage + 1
                            }
                        }
                    }
                case .failure(_):
                    self?.isLoading = false
                    self?.isFailure = true
                }
            }
        })
    }
    
    func getNumberOfContacts() -> Int {
        return contactData.count
    }

    func getUserContactFor(_ index:Int) -> userContact? {
        return contactData[index]
    }
    
}

