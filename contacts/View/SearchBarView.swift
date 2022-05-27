//
//  SearchBarView.swift
//  contacts
//
//  Created by naga vineel golla on 5/26/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @EnvironmentObject var viewModel: ContactListViewModel
    @State private var isEditing = false
    
    var body: some View {
            HStack {
                TextField("Search Contact", text: $viewModel.searchQuery)
                    .foregroundColor(.black)
                    .padding(.leading,40)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.horizontal)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            Spacer()
                            
                            if isEditing {
                                Button(action: { viewModel.searchQuery = "" }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .padding(.vertical)
                                })
                            }
                        }
                            .padding(.horizontal,32)
                            .foregroundColor(.gray)
                    )
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.viewModel.searchQuery = ""
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                            .padding(.trailing)
                            .padding(.leading, 0)
                    }
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
                }
            }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
