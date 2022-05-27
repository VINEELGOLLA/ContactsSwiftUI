//
//  FilteredContactView.swift
//  contacts
//
//  Created by naga vineel golla on 5/27/22.
//

import SwiftUI

struct FilteredContactView: View {
    @EnvironmentObject var viewModel: ContactListViewModel
    var filteredContactData: [userContact]
    
    var body: some View {
        List {
            ForEach(filteredContactData , id: \.id) { contact in
                NavigationLink(
                    destination: ContactDetail(userContact: contact),
                    label: {
                        HStack {
                            ImageViewSmall(urlString: contact.picture?.medium ?? "")
                            Text("\(contact.name?.getUserFullName ?? "")")
                                .font(.title3)
                        }
                    }
                )}
        }
        .navigationTitle("Contacts List")
        .listStyle(PlainListStyle())
    }
}

struct FilteredContactView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredContactView(filteredContactData: [])
    }
}
