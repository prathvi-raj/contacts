//
//  ContactInfo.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation

// MARK: - ContactInfo
struct ContactInfo: Codable {
    let id: Int
    let firstName, lastName, email, phoneNumber: String?
    let profilePic: String?
    let isFavorite: Bool
    let createdAt, updatedAt: String?
    
    var photo: String {
        return "http://gojek-contacts-app.herokuapp.com" + (profilePic ?? "")
    }
    
    var nameToDisplay: String {
        return (firstName?.capitalized ?? "") + " " + (lastName ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
        case profilePic = "profile_pic"
        case isFavorite = "favorite"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
