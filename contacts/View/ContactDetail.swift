//
//  DetailScreen.swift
//  contacts
//
//  Created by naga vineel golla on 5/24/22.
//

import SwiftUI

struct ContactDetail: View {
    var userContact : userContact?
    
    var body: some View {
        VStack {
            ImageView(urlString: userContact?.picture?.large ?? "")
                .scaledToFit()
                .aspectRatio(contentMode: .fill)  
            Spacer()
            List {
                Text("Name: \(userContact?.name?.getUserFullName ?? "")")
                Text("Email: \(userContact?.email ?? "")")

                Text("Phone Number: \(userContact?.phone ?? "")")

                Text("Dob: \(userContact?.dob?.date ?? "")")
                
                Text("Address: \(userContact?.location?.fullAddress ?? "")")
            }
            .navigationBarTitle("\(userContact?.name?.first ?? "")", displayMode: .inline)
            .listStyle(PlainListStyle())
        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetail(userContact: nil)
    }
}
