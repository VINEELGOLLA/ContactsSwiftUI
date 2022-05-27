//
//  ContentView.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContactListViewModel = ContactListViewModel()
    @State var isShowingAlert: Bool = false
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
                case.loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(3)
                case .success(let contactData):
                    List {
                        ForEach(contactData , id: \.id) { contact in
                            NavigationLink(
                                destination: ContactDetail(userContact: contact),
                                label: {
                                    HStack {
                                        ImageViewSmall(urlString: contact.picture?.medium ?? "")
                                        Text("\(contact.name?.getUserFullName ?? "")")
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
                    
                case .failed(let error):
                    let _ = print(error.localizedDescription.description)
            }
                
        }
        .alert(isPresented: $viewModel.isFailure, content: {
            Alert(title: Text("FAILURE"), message: Text("Please Try some time later"), dismissButton: .default(Text("Okay"), action: {
                self.viewModel.isFailure = false
            }))
        })

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
