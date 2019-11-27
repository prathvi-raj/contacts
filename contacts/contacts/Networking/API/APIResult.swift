//
//  APIResult.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation

enum APIResult <Value, F: Decodable> {
    
    case success(value: Value)
    
    case failure(error: APICallError)
    
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .success(value: value)
        } catch let error as APICallError {
            self = .failure(error: error)
        } catch let error {
            plog(error)
            self = .failure(error: APICallError(status: .failed))
        }
    }
}
