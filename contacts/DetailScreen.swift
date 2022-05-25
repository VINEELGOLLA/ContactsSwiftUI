//
//  DetailScreen.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import SwiftUI

struct DetailScreen: View {
    
    var userContact : userContact?
    
    var body: some View {
        VStack {
            ImageViewLarge(urlString: userContact?.picture?.large ?? "")
            List {
                Text("Name: \(userContact?.name?.first ?? "")")
                Text("Email: \(userContact?.email ?? "")")

                Text("Phone Number: \(userContact?.phone ?? "")")

                Text("Dob: \(userContact?.dob?.date ?? "")")
                
                Text("Address: \(userContact?.location?.fullAddress ?? "")")
            }
            .navigationTitle("Contacts Detail")
            .listStyle(PlainListStyle())


        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(userContact: nil)
    }
}
