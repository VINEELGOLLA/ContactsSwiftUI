//
//  ResultState.swift
//  contacts
//
//  Created by naga vineel golla on 5/26/22.
//

import Foundation

enum ResultState {
    case loading
    case success
    case failed(error: Error)
}
