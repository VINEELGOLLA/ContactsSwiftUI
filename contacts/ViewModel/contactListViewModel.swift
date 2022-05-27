//
//  contactListViewModel.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import Foundation

class ContactListViewModel: ObservableObject {
    
    @Published var searchQuery: String = "" {
        didSet {
            if !searchQuery.isEmpty {
                filterContacts()
            } else {
                self.showFilteredContacts = false
                self.filteredContacts = []
            }
        }
    }
    
    private(set) var contactData: [userContact] = []
    private(set) var filteredContacts: [userContact] = []
    @Published var state: ResultState = .loading
    @Published var isFailure: Bool = false
    @Published var showFilteredContacts: Bool = false
    
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
                    if let contactData = data, let userContactResults = contactData.results, !(self?.showFilteredContacts ?? true) {
                        self?.contactData.append(contentsOf: userContactResults)
                        if userContactResults.count < 20 {
                            self?.isFull = true
                        } else {
                            if let currPage = self?.currentPage {
                                self?.currentPage = currPage + 1
                            }
                        }
                        self?.state = .success
                    }
                case .failure(let error):
                    self?.state = .failed(error: error)
                    self?.isFailure = true
                }
            }
        })
    }
    
    private func filterContacts() {
        
        let filteredContacts = contactData.filter({
            ($0.name?.getUserFullName ?? "").lowercased().hasPrefix(searchQuery.lowercased())
        })
        
        self.filteredContacts = filteredContacts
        self.state = .success
        self.showFilteredContacts = true
    }
}

