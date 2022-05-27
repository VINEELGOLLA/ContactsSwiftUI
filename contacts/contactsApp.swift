//
//  contactsApp.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import SwiftUI

@main
struct contactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ContactListViewModel())
        }
    }
}
