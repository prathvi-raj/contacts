//
//  APIRouterType.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRouterType: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}
