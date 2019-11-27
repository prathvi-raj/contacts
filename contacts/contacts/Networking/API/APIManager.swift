//
//  APIManager.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

class APIManager {
    
    static let shared: APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager: SessionManager
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func requestObservable(api: APIRouterType) -> Observable<DataRequest> {
        return sessionManager.rx.request(urlRequest: api)
    }
    
//    func requestUploadObservable(uploader: FileUploadRouter) -> Observable<UploadRequest>  {
//        return sessionManager.rx.upload(uploader.data(), urlRequest: uploader)
//    }
}
