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
                            ImageView(urlString: contact.picture?.medium ?? "")
                                .scaledToFit()
                                .frame(width: 100, height: 100, alignment: .center)
                                .cornerRadius(8)
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
