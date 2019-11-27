//
//  ContactsRouter.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import Alamofire

enum ContactsRouter: APIRouterType {
    
    case products
    case createContact(info: CreateContactInfo)
    case contacts
    case contactInfo(id: Int)
    case deleteContact(id: Int)
    
    func asURLRequest() throws -> URLRequest {
        
        let baseURL: String = {
            switch self {
            case .contacts, .contactInfo, .createContact, .deleteContact:
                return APIConstants.base1URL.absoluteString
            default:
                return APIConstants.baseURL.absoluteString
            }}()
        
        let apiVersion: String? = {
            switch self {
            case .products, .contacts, .contactInfo, .createContact, .deleteContact:
                return nil
            }
        }()
        
        let relativePath: String? = {
            switch self {
            
            case .products:
                return "ss-local-files/products.json"
                
            case .contacts, .createContact:
                return "contacts.json"
                
            case .contactInfo(let id), .deleteContact(let id):
                return "contacts/\(id).json"
            }
        }()
        
        var method: HTTPMethod {
            switch self {
            case .products, .contacts, .contactInfo:
                return .get
            case .createContact:
                return .post
            case .deleteContact:
                return .delete
            }
        }
        
        let params: ([String: Any]?) = {
            var params: [String: Any] = [:]
            switch self {
                
            case .products, .contacts, .contactInfo, .deleteContact:
                break
                
            case .createContact(let info):
                if let dictionary = info.dictionary {
                    params = dictionary
                }
            }
            return params
        }()
        
        let headers: [String:String]? = {
            let headers: [String: String] = ["Content-Type": "application/json"]
            switch self {
            default:
                return headers
            }
        }()
        
        let url: URL = {
            
            var completeUrl = URL(string: baseURL)!
            
            if let apiVersion = apiVersion {
                completeUrl = completeUrl.appendingPathComponent(apiVersion)
            }
            
            if let relativePath = relativePath {
                completeUrl = completeUrl.appendingPathComponent(relativePath)
            }
            
            return completeUrl
        }()
        
        let encoding: ParameterEncoding = {
            
            switch self {
            case  .createContact:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return try encoding.encode(urlRequest, with: params)
    }
}

/*
 
 http://gojek-contacts-app.herokuapp.com/contacts.json
 http://gojek-contacts-app.herokuapp.com/contacts/10149.json
 
 
 */
