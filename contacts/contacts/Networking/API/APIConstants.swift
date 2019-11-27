//
//  APIConstants.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation


struct APIConstants {
    
    // The API's base URL
    static var baseURL: URL {
        return URL(string: "https://s3.ap-south-1.amazonaws.com/")!
    }
    
    // The API's base URL
    static var base1URL: URL {
        return URL(string: "http://gojek-contacts-app.herokuapp.com/")!
    }
    
    //The parameters (Queries) that we're gonna use
    enum Parameters: String {
        case url = "url"
    }
    
    //The header fields
    enum HttpHeaderField: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}

