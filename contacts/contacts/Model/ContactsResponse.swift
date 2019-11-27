//
//  ContactsResponse.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation

// MARK: - ContactsResponseElement
struct Contact: Codable {
    let id: Int
    let firstName, lastName: String?
    let profilePic: String?
    let isFavorite: Bool
    let url: String?
    
    var nameToDisplay: String {
        return (firstName?.capitalized ?? "") + " " + (lastName ?? "")
    }
    
    var photo: String {
        return "http://gojek-contacts-app.herokuapp.com" + (profilePic ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case isFavorite = "favorite"
        case url
    }
}

typealias ContactsResponse = [Contact]
