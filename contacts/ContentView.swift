//
//  ContentView.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContactListViewModel = ContactListViewModel()
    
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(3)
            } else {
                List {
                    ForEach(viewModel.contactData , id: \.id) { contact in
                        NavigationLink(
                            destination: DetailScreen(userContact: contact),
                            label: {
                                HStack {
                                    UrlImageView(urlString: contact.picture?.medium ?? "")
                                    Text("\(contact.name?.getUserFullName ?? "lol")")
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
        .alert(isPresented: $viewModel.isFailure, content: {
            Alert(title: Text("FAILURE"), message: Text("Please Try some time later"), dismissButton: .default(Text("Okay")))
        })

}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
