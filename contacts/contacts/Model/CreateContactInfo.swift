//
//  CreateContactInfo.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation

// MARK: - ContactInfo
struct CreateContactInfo: Codable {
    
    let firstName, lastName, email, phoneNumber: String
    let isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
        case isFavorite = "favorite"
    }
}

