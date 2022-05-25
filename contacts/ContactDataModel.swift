//
//  ContactDataModel.swift
//  contacts
//
//  Created by naga vineel golla on 5/23/22.
//

import Foundation

// MARK: - CharcterDataModel
struct ContactListResponse: Codable, Identifiable {
    let results: [userContact]?
    let info: Info?
    let id: String = UUID().uuidString
}

// MARK: - Info
struct Info: Codable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

// MARK: - Result
struct userContact: Codable, Identifiable {
    let id: String = UUID().uuidString
    let name: Name?
    let location: Location?
    let email: String?
    let dob: Dob?
    let phone, cell: String?
    let picture: Picture?
}

// MARK: - Dob
struct Dob: Codable {
    let date: String?
    let age: Int?
}

// MARK: - ID
struct ID: Codable {
    let name, value: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street?
    let city, state: String?
    let postcode: Postcode
    let coordinates: Coordinates?
    let timezone: Timezone?
    
    var fullAddress: String {
        return "\(street?.fullStreetName ?? ""), \(city ?? ""), \(state ?? "") - \(postcode.getPostalCodeString())"
    }
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    func getPostalCodeString() -> String {
        switch self {
        case .integer(let postalCode):
            return "\(postalCode)"
        case .string(let postalCode):
        return postalCode
        }
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String?
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
    
    var fullStreetName: String {
        return "\(String(number)) \(name)"
    }
}


// MARK: - Timezone
struct Timezone: Codable {
    let offset, timezoneDescription: String?

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String?
    
    var getUserFullName: String {
        return "\(title ?? "") \(last ?? "") \(first ?? "")"
    }
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String?
}

