//
//  ContactView.swift
//  contacts
//
//  Created by naga vineel golla on 5/27/22.
//

import SwiftUI

struct ContactView: View {
    @EnvironmentObject var viewModel: ContactListViewModel
    var contactData: [userContact]
    
    var body: some View {
        List {
            ForEach(contactData , id: \.id) { contact in
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
            if !viewModel.isFull {
                Text("Downloading data.....")
                    .onAppear(perform: {
                        viewModel.fetchData()
                    })
                }
        }
        .navigationTitle("Contacts List")
        .listStyle(PlainListStyle())
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(contactData: [])
    }
}
