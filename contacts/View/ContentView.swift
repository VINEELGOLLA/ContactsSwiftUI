//
//  ContentView.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ContactListViewModel
    @State var isShowingAlert: Bool = false
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
                case.loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(3)
            case .success:
                VStack {
                    SearchBarView()
                    
                    if viewModel.showFilteredContacts {
                        FilteredContactView(filteredContactData: viewModel.filteredContacts)
                    } else {
                        ContactView(contactData: viewModel.contactData)
                    }
                }
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
