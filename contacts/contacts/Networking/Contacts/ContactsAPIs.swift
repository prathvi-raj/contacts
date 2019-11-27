//
//  ContactsAPIs.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class ContactsAPIs: APIRequestType {
    
    func products() -> Observable<APIResult<ProductsResponse, ContactsError>> {
        return request(APIManager.shared.requestObservable(api: ContactsRouter.products))
    }
    
    func contacts() -> Observable<APIResult<ContactsResponse, ContactsError>> {
        return request(APIManager.shared.requestObservable(api: ContactsRouter.contacts))
    }
    
    func contactInfo(id: Int) -> Observable<APIResult<ContactInfo, ContactsError>> {
        return request(APIManager.shared.requestObservable(api: ContactsRouter.contactInfo(id: id)))
    }
    
    func createContact(info: CreateContactInfo) -> Observable<APIResult<ContactsResponse, ContactsError>> {
        return request(APIManager.shared.requestObservable(api: ContactsRouter.createContact(info: info)))
    }
    
    func deleteContact(id: Int) -> Observable<APIResult<ContactsResponse, ContactsError>> {
        return request(APIManager.shared.requestObservable(api: ContactsRouter.deleteContact(id: id)))
    }
    
    func updateContact(id: Int) -> Observable<APIResult<ContactsResponse, ContactsError>> {
        return request(APIManager.shared.requestObservable(api: ContactsRouter.deleteContact(id: id)))
    }
}
